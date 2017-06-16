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

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('catalog');

        $user = Session::get('user');
        $currency = Session::get('currency');

        $this->category = new \modules\catalog\models\Category($this->config, $currency, $user);
    }

    public function init()
    {
        parent::init();

        events()->add('boot', function (){
            Route::getInstance()->get('{url}/filter/{any}', function($url, $filter){
                Route::getInstance()->call('\system\frontend\Page', 'displayUrl', [$url]);
            });
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

            if($page['type'] == $this->config->type->mamufacturer){
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

        $filter = ['selected' => []];

        $_filter = new CategoryFilter($this->category, $this->languages);
        $_filter->make($this->request);
        $filter['features'] = $_filter->features->get($category['id']);

        /** FILTERING <<<<<  **/

        $tmmp = $this->category->products->category($category['id'])->total();

        $total = $tmmp['total'];

        $filter['minp'] = $tmmp['minp'];
        $filter['maxp'] = $tmmp['maxp'];


        // pagination
        $pagination = $this->app->pagination->init($total, $ipp, $category['id'] . ';', $_GET);
        $limit = $pagination->getLimit();
        $category['pagination'] = $pagination;

        // assign all
        $category['filter'] = $filter;
        $category['products_total'] = $total;
        $category['products'] = $this->category->products->limit($limit[0], $limit[1])->get();

        $category['sorting'] = $this->config->sorting;
        $category['paginate_options'] = $this->config->paginate_options;

        $this->template->assign('category', $category);
    }

    public function displayProduct($product)
    {

    }

    public function displayManufacturer($product)
    {

    }
}