<?php
namespace modules\megamenu\controllers\admin;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use system\Backend;
use system\core\DataFilter;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\models\ContentRelationship;

/**
 * Class Megamenu
 * @package modules\megamenu\controllers\admin
 */
class Megamenu extends Backend
{
    /**
     * @var null
     */
    private $config;

    /**
     * @var \modules\megamenu\models\Megamenu
     */
    private $megamenu;

    /**
     * Megamenu constructor.
     */
    public function __construct()
    {
        parent::__construct();
        $this->config = module_config('megamenu');
        $this->megamenu = new \modules\megamenu\models\Megamenu();
    }

    public function init()
    {
        $this->assignToNav(t('megamenu.action_index'), 'module/run/megamenu', t('megamenu.action_index_icon'), null, 30);
        $this->template->assignScript("modules/megamenu/js/admin/megamenu.js");

//        DataFilter::add
//        (
//            'nav.items.content_types',
//            function($types)
//            {
//                $types[] = $this->config->category_type;
//                return $types;
//            }
//        );

//        EventsHandler::getInstance()->add('content.params', [$this, 'contentParams']);
//        EventsHandler::getInstance()->add('content.process', [$this, 'contentProcess']);
//        EventsHandler::getInstance()->add('dashboard', [$this, 'dashboard']);
//        EventsHandler::getInstance()->add('content.process', [new Tags(), 'process']);
    }

    public function dashboard()
    {
//        $this->posts->num = 3;
//        $this->template->assign('items', $this->posts->get());
//        return $this->template->fetch('modules/megamenu/dashboard');
    }

    /**
     * @param $content
     * @return string
     */
    public function contentParams($content)
    {
        $type = $this->posts->getContentType($content['id']);
        if(!in_array($type, $this->allowed_types)) return '';

        $this->template->assign('selected_categories', $this->relations->getCategories($content['id']));

        $this->template->assign('categories', $this->categories);

        return $this->template->fetch('modules/megamenu/select_categories');
    }

    /**
     * @param $id
     */
    public function contentProcess($id)
    {
        $type = $this->mContent->getContentType($id);
        if($type != $this->config->post_type) return;

        $categories = $this->request->post('categories');
        $this->relations->saveContentCategories($id, $categories, $this->config->post_type);


    }


    public function index($parent_id=0)
    {
        if($parent_id > 0){
            $parents = $this->mContent->getParents($parent_id);// d($parents);die;

            $c = count($parents)-1;
            foreach ($parents as $k=>$parent) {
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/megamenu/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/megamenu/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('megamenu');
        $t  -> ajax('module/run/megamenu/index/0')
            -> th(t('megamenu.table.id'), 'm.id', 1, 1, 'width: 60px')
            -> th(t('megamenu.table.name'), 'm.name', 1, 1)
            -> th(t('megamenu.table.alias'), 'm.alias', 1, 1, 'width: 250px')
            -> th(t('megamenu.table.created'), 'm.creation_time', 0,1, 'width: 200px')
            -> th(t('megamenu.table.updated'), 'm.update_time', 0, 1, 'width: 200px')
            -> th(t('megamenu.table.functions'), null, 0, 0, 'width: 180px')
        ;
//        $t->get('m.alias',null,null,null);
        $t->get('m.status',null,null,null);
//        $t->get('c.isfolder',null,null,null);
//        $t->get('CONCAT(u.name, \' \' , u.surname) as owner',null,null,null);


        if($this->request->isXhr()){
            $t->from('__megamenu m');
            $t->execute();
            $res = array();

//        $comments = new Comments();
//d($t->getResults(false));
            foreach ($t->getResults(false) as $i=>$row) {

//
//                $t_comments_new = 0;//$comments->getTotalNew($row['id']);
//
//                $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
//                $icon_link = Icon::create('fa-external-link');
//                $status = t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] = $row['name'];
                $res[$i][] = '<input type=text value="'.$row['alias'].'" readonly="readonly" />';
//                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/megamenu/edit/{$row['id']}'>{$icon}  {}</a>"
//                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
//                    . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
//                    . ($t_comments_new > 0 ? ", <small class='label label-info'>{$t_comments_new} новий</small>" : "")
//                ;
                $res[$i][] = date('d.m.Y H:i:s', strtotime($row['creation_time']));
                $res[$i][] = $row['update_time'] ? date('d.m.Y H:i:s', strtotime($row['update_time'])) : '';
                $res[$i][] =
                    (string)(
                    $row['status'] == 'published' ?
                        Link::create
                        (
                            Icon::create(Icon::TYPE_PUBLISHED),
                            [
                                'class' => 'btn-primary',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/megamenu/edit/" . $row['id'], 'title' => t('common.title_edit')]
                    )
                    //.
//                    ($row['isfolder'] == 0 ? (string)Button::create
//                    (
//                        Icon::create(Icon::TYPE_DELETE),
//                        ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => t($this->type.'.delete_question')]
//                    ) : "")

                ;
            }

            echo $t->render($res, $t->getTotal());//$this->response->body($t->render($res, $t->getTotal()))->asJSON();
            return;
        }

        $this->output($t->init());
    }

    public function create()
    {
        $id = parent::create(0);

        return $this->edit($id);
    }

    public function edit($id)
    {
        $this->megamenu->setWhere(['id = '. $id]);
//        $this->megamenu->debug(1);


//        $this->appendToPanel
//        (
//            (string)Link::create
//            (
//                t('common.back'),
//                ['class' => 'btn-md', 'href'=> 'module/run/megamenu' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
//            )
//        );

//        $tags = new Tags();
//        EventsHandler::getInstance()->add('content.params.after', [$tags, 'index']);

//        $this->template->assign('sidebar', $this->template->fetch('modules/megamenu/categories/tree'));
//        $this->template->assign('groups', $this->usersGroup->get());
        $this->template->assign('data', $this->megamenu->getData());
//        $this->template->assign('action', 'edit');
        $this->output($this->template->fetch('modules/megamenu/form'))    ;
//        parent::edit($id);
    }

    public function process($id= null)
    {

    }

    public function delete($id)
    {

    }
}