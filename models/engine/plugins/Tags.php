<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 23.03.16 : 17:41
 */

namespace models\engine\plugins;

use models\Engine;

defined("CPATH") or die();

/**
 * Class Tags
 * @package models\engine\plugins
 */
class Tags extends Engine
{
    public function set($content_id)
    {
        $tags  = $this->request->post('tags');
        $_tags = $this->getContentTags($content_id);

        foreach ($tags as $languages_id => $str) {
            $tc = isset($_tags[$languages_id]) ? $_tags[$languages_id] : [];
            $a  = explode(',', $str);
            foreach ($a as $k=>$tag) {

                $tag = strip_tags($tag);
                $tag = trim($tag);

                if(empty($tag)) continue;

                $tags_id = $this->getTagId($tag);

                if(empty($tags_id)){
                    $tags_id = $this->create($tag);
                }

                $this->addToContent($tags_id, $content_id, $languages_id);

                if(isset($tc[$tags_id])) {
                    unset($tc[$tags_id]);
                }
            }

            // видалю непотрібні
            if(! empty($tc)){
                foreach ($tc as $item) {
                    self::deleteRow('content_tags', $item['ct_id']);
                    $t = self::$db
                        ->select("select count(id) as t from content_tags where tags_id={$item['id']}")
                        ->row('t');
                    if($t == 0){
                        $this->deleteRow('tags', $item['id']);
                    }
                }
            }
        }
    }

    private function getContentTags($content_id)
    {
        $tags = self::$db
            ->select("
              select t.id, t.tag, ct.languages_id, ct.id as ct_id
              from content_tags ct
              join tags t on t.id=ct.tags_id
              where ct.content_id={$content_id}
            ")
            ->all();
        $res = [];
        foreach ($tags as $tag) {
            $res[$tag['languages_id']][$tag['id']] = $tag;
        }
        return $res;
    }

    public function getContentSimple($content_id)
    {
        $tags = self::$db
            ->select("
              select t.tag, ct.languages_id
              from content_tags ct
              join tags t on t.id=ct.tags_id
              where ct.content_id={$content_id}
            ")
            ->all();
        $res = [];
        foreach ($tags as $tag) {
            $res[$tag['languages_id']][] = $tag['tag'];
        }
        return $res;
    }

    private function create($tag)
    {
        $id = $this->getTagId($tag);

        if($id > 0) return $id;

        return $this->createRow('tags', ['tag' => $tag]);
    }

    /**
     * @param $tag
     * @return array|mixed
     */
    private function getTagId($tag)
    {
        return self::$db
            ->select("select id from tags where tag = '{$tag}' limit 1")
            ->row('id');
    }

    /**
     * @param $tags_id
     * @param $content_id
     * @param $languages_id
     * @return bool|string
     */
    private function addToContent($tags_id, $content_id, $languages_id)
    {
        $id = self::$db
            ->select("
              select id
              from content_tags
              where content_id={$content_id} and tags_id={$tags_id} and languages_id={$languages_id} limit 1
              ")
            ->row('id');

        if($id > 0) return 0;

        return $this->createRow
        (
            'content_tags',
            ['tags_id' => $tags_id, 'content_id' => $content_id, 'languages_id' => $languages_id]
        );
    }
}