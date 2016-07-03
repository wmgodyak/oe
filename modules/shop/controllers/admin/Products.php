<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:11
 */

namespace modules\shop\controllers\admin;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use modules\shop\controllers\admin\products\Features;
use modules\shop\models\Categories;
use system\components\content\controllers\Content;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\models\ContentRelationship;

/**
 * Class shop
 * @package modules\shop\controllers\admin
 */
class Products extends Content
{
    private $categories;
    private $relations;
    private $contentTypes;
    private $allowed_types = ['product'];


    public function __construct()
    {
        parent::__construct('product');

        $this->form_action = "module/run/shop/products/process/";
        // hide custom block
        $this->form_display_blocks['intro']    = false;
        $this->form_display_params['parent']   = false;
        $this->form_display_params['owner']    = false;
        $this->form_display_params['pub_date'] = false;
        $this->form_display_blocks['features'] = false;

        $this->relations = new ContentRelationship();
        $this->categories = new Categories('products_categories');
        $this->contentTypes = new \system\models\ContentTypes();


        EventsHandler::getInstance()->add('content.main', [$this, 'contentParams']);
        EventsHandler::getInstance()->add('content.process', [$this, 'contentProcess']);

        $prices = new Prices();
        EventsHandler::getInstance()->add('content.main.after', [$prices, 'index']);
        EventsHandler::getInstance()->add('content.process', [$prices, 'process']);
    }


    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/shop/products/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                $this->t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/shop/products/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('module/run/shop/products/index/' . $parent_id)
//            ->orderDef(0, 'desc')
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('common.name'), 'ci.name', 1, 1)
            -> th($this->t('common.created'), 'c.created', 0,1, 'width: 200px')
            -> th($this->t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);

        if($this->request->isXhr()){

            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages_id}")
                -> where("c.status in ('published', 'hidden')");

            if($parent_id > 0){
                $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$parent_id}");
            }

            $t-> execute();

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {
                $img = $this->images->cover($row['id'], 'thumbs');

                $img = $img ? "<img style='max-width:30px; max-height: 30px; float:left; margin-right: 1em;' src='/{$img}'>" : "<i class='fa fa-file-image-o'></i>";
                $icon_link = Icon::create('fa-external-link');
                $status = $this->t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    $img .
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/shop/products/edit/{$row['id']}'>{$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                ;
                $res[$i][] = date('d.m.Y H:i:s', strtotime($row['created']));
                $res[$i][] = $row['updated'] ? date('d.m.Y H:i:s', strtotime($row['updated'])) : '';
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Link::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'b-'.$this->type.'-hide',
                                'title' => $this->t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'b-'.$this->type.'-pub',
                                'title' => $this->t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/shop/products/edit/" . $row['id'], 'title' => $this->t('common.title_edit')]
                    )
                ;
            }

            echo $t->render($res, $t->getTotal());//$this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }

        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));
        $this->output($t->init());
    }

    public function create()
    {
        $id = parent::create(0);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $parent_id = $this->mContent->getData($id, 'parent_id');

        $this->appendToPanel((string)Link::create
        (
            $this->t('common.back'),
            ['class' => 'btn-md', 'href'=> 'module/run/shop/products' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
        )
        );

        $features = new Features();
        EventsHandler::getInstance()->add('content.main.after', [$features, 'index']);

        $this->template->assign('sidebar', $this->template->fetch('shop/categories/tree'));

        parent::edit($id);
    }

    /**
     * @param $content
     * @return string
     */
    public function contentParams($content)
    {
        $ct = $this->contentTypes->getData($content['types_id'], 'type');
        if(!in_array($ct, $this->allowed_types)) return '';

        $this->template->assign('selected_categories', $this->relations->getCategories($content['id']));
        $this->template->assign('main_categories_id', $this->relations->getMainCategoriesId($content['id']));
        $this->template->assign('categories', $this->categories->get(0,1));

        return $this->template->fetch('shop/select_categories');
    }

    /**
     * @param $id
     */
    public function contentProcess($id)
    {
        $this->relations->saveContentCategories($id);
        $this->relations->saveMainCategory($id);

        return $this->features('contentProcess', $id);
    }


    public function features($action = 'index')
    {
        include "products/Features.php";

        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new products\Features();

        return call_user_func_array(array($controller, $action), $params);
    }
}