<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 01.07.16 : 12:24
 */

namespace modules\shop\models\categories;

use system\models\Currency;

defined("CPATH") or die();

/**
 * Class Features
 * @package modules\shop\models\categories
 */
class Features extends \system\models\Features
{
    private $selected_features = [];
    private $currency;

    public function __construct()
    {
        parent::__construct();

        $this->currency = new Currency();
    }

    /**
     * @param $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function get($categories_id)
    {
        $this->parseGetParams();
        $items =
            self::$db->select("
              select f.id, fi.name, f.code,f.type
              from __features_content fc
              join __features f on fc.features_id=f.id and f.status='published'
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where fc.content_id={$categories_id}
              order by abs(fc.position) asc
           ")->all();

        foreach ($items as $k=>$item) {
            if($item['type'] == 'folder'){
                $items[$k]['items'] = $this->get($categories_id);
            } else{
                $items[$k]['values'] = $this->getValues($item, $categories_id);
            }
        }

        return $items;
    }

    /**
     * @param $feature
     * @param $categories_id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    private function getValues($feature, $categories_id)
    {
       $items =  self::$db->select("
              select f.id, fi.name, f.code
              from  __features f
              join __features_info fi on fi.features_id=f.id and fi.languages_id={$this->languages_id}
              where f.parent_id={$feature['id']} and f.status = 'published'
              order by fi.name asc
           ")->all();
        foreach ($items as $k=>$item) {
            $items[$k]['active'] = isset($this->selected_features[$feature['code']]) && in_array($item['id'], $this->selected_features[$feature['code']]);
            $items[$k]['url']    = $this->makeValueUrl($feature, $item, $categories_id);
            $items[$k]['total']  = $this->getValuesCount($item['id'], $categories_id);
        }

        return $items;
    }

    private function makeValueUrl($feature, $value, $categories_id)
    {
        $url = $categories_id . ';filter/';

        $sp = $this->selected_features;

        if(isset($sp[$feature['code']])){
            $k = array_search($value['id'], $sp[$feature['code']]);
            if($k !== false){
                unset($sp[$feature['code']][$k]);
                if(empty($sp[$feature['code']])) unset($sp[$feature['code']]);
            } else {
                $sp[$feature['code']][] = $value['id'];
            }
        } else {
            $sp[$feature['code']][] = $value['id'];
        }

        $i=0;
        foreach ($sp as $f => $v) {
            $url .= ($i > 0 ? ';': '') . "$f-" . implode(',' , $v);
            $i++;
        }

        return $url;
    }

    /**
     * @return array|null
     */
    public function parseGetParams()
    {
        $filter = $this->request->param('filter');
        if(empty($filter)) return null;

        $a = explode(';', $filter);
        foreach ($a as $k=>$f) {
            $b = explode('-', $f);
            if(!isset($b[1]) || empty($b[1])) continue;

            $this->selected_features[$b[0]] = explode(',', $b[1]);
        }

        return $this->selected_features;
    }

    public function getFormAction()
    {
        return $_SERVER['REQUEST_URI'];
    }

    /**
     * @param $values_id
     * @param $categories_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    private function getValuesCount($values_id, $categories_id)
    {
        return self::$db
            ->select("
              select count(cf.id) as t
              from __content_relationship cr
              join __content_features cf on cf.content_id=cr.content_id and cf.values_id={$values_id}
              where cr.categories_id={$categories_id}
              ")
            ->row('t');
    }

    public function getMinMaxPrice($categories_id, $group_id)
    {
        $cu_on_site = $this->currency->getOnSiteMeta();
        $cu_main    = $this->currency->getMainMeta();

        return self::$db
            ->select("
              select
              MIN(CASE
            WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END) as minp,
              MAX(CASE
            WHEN c.currency_id = {$cu_on_site['id']} THEN pp.price
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id = {$cu_main['id']} THEN pp.price * {$cu_on_site['rate']}
            WHEN c.currency_id <> {$cu_on_site['id']} and c.currency_id <> {$cu_main['id']} THEN pp.price / cu.rate * {$cu_on_site['rate']}
            END) as maxp
              from __content_relationship cr
              join __products_prices pp on pp.content_id=cr.content_id and pp.group_id={$group_id}
              join __content c on c.id=cr.content_id
              join __currency cu on cu.id = c.currency_id
              where cr.categories_id={$categories_id}
              ")
            ->row();
    }

    /**
     * @param $code
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getIDByCode($code)
    {
        return self::$db->select("select id from __features where code = '{$code}' limit 1")->row('id');
    }
}