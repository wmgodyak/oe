<?php

namespace modules\catalog\controllers;

use system\core\Route;
use system\core\Session;
use system\Frontend;

/**
 * Class Catalog
 * @package modules\catalog\controllers
 */
class Catalog extends Frontend
{
    private $config;
    private $category;
    private $currency;
    private $user;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $this->user = Session::get('user');
        $this->currency = Session::get('currency');

        $this->category = new \modules\catalog\models\Category($this->config, $this->currency, $this->user);
    }

    public function init()
    {
        parent::init();

        events()->add('boot', function (){

            Route::getInstance()->uriFilter(function($uri){
                $uri = preg_replace_callback("@([a-zA-Z0-9_]+)(/filter/.*)@iu", function($m){

                    $filter = str_replace('/filter/', '', $m[2]);
                    $this->request->param('filter', $filter);

                    return $m[1];
                }, $uri);

               return $uri;
            });

//            Route::getInstance()->get('{url}/filter/{any}', function($url, $filter){
//                Route::getInstance()->call('\system\frontend\Page', 'displayUrl', [$url]);
//            });
//            $routes[]  = array('/([a-z]{2})/([a-z0-9-_/]+)/filter/(.*)', 'system\Front', 'lang/url/filter/filter');
//            $routes[]  = array('/([a-z0-9-_/]+)/filter/(.*)', 'system\Front', 'url/filter/filter');
        });

        events()->add('init', function($page){

            if($page['type'] == $this->config->type->category){
                return $this->assignCategory($page);
            }

            if($page['type'] == $this->config->type->product){
                return $this->displayProduct($page);
            }

            if($page['type'] == $this->config->type->manufacturer){
                return $this->displayManufacturer($page);
            }
        });
    }

    public function assignCategory($category)
    {
        // sorting
        $allowed = $this->config->sorting;

        $sort = $this->request->get('sort');

        if(!in_array($sort, $allowed)){
            $sort = $allowed[0];
        }

        switch ($sort){
            case 'popular':
                break;
            case 'cheap':
                $this->category->products->orderBy("available desc, abs(price) asc");
                break;
            case 'expensive':
                $this->category->products->orderBy("available desc, abs(price) desc");
                break;
            case 'novelty':
                $this->category->products->orderBy("available desc, abs(c.id) desc");
                break;
        }

        // ordering
        $allowed = $this->config->paginate_options;

        $ipp = $this->request->get('ipp');

        if(!in_array($ipp, $allowed)){
            $ipp = $allowed[0];
        }

        /** FILTERING >>>>>  **/

        $url = $category['url'] ;

        $f = $this->request->param('filter');
        if(!empty($f)){
            $url = $category['url'] . '/filter/' . $this->request->param('filter');
        }

        $this->template->assign('filter_url', $url);

        $this->request->param('url', $url);
        $this->request->param('category_url', $category['url']);
        $this->request->param('category_id', $category['id']);

        $manufacturer = new \modules\catalog\models\Manufacturers($this->config, $this->category, $this->request);
        $filter = new Filter($category, $this->request, $this->category, $this->languages, $manufacturer);

        $tmmp = $this->category->products->category($category['id'])->total();

        $filter->minPrice($tmmp['minp']);
        $filter->maxPrice($tmmp['maxp']);

        /** FILTERING <<<<<  **/

        $total = $tmmp['total'];

        // pagination
        $pagination = $this->app->pagination->init($total, $ipp, $url, $_GET);
        $limit = $pagination->getLimit();
        $category['pagination'] = $pagination;

        // assign all
        $category['products_total'] = $total;
        $category['products'] = $this->category->products->limit($limit[0], $limit[1])->get();

        $category['sorting'] = $this->config->sorting;
        $category['paginate_options'] = $this->config->paginate_options;

        $this->template->assign('filter', $filter);
        $this->template->assign('category', $category);
    }

    public function displayProduct($page)
    {
        $group_id = isset($user['group_id']) ? $user['group_id'] : $this->config->group_id;
        $product = new \modules\catalog\models\Product($page['id'], $this->languages, $this->currency, $group_id);

        foreach ($page as $k=>$v) {
            $product->set($k, $v);
        }

//        dd($product->features->short());
        dd($product->variants->get());

        $this->template->assign('product', $product);
    }

    public function displayManufacturer($product)
    {

    }
}