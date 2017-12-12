<?php
namespace modules\blog\controllers\admin;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\bootstrap\Link;
use modules\blog\models\Posts;
use system\components\content\controllers\Content;
use system\core\DataFilter;
use system\core\DataTables2;
use system\core\EventsHandler;
use system\core\exceptions\Exception;
use system\models\ContentRelationship;

/**
 * Class Blog
 * @package modules\blog\controllers\admin
 */
class Blog extends Content
{
    private $categories;
    private $relations;
    private $posts;
    private $config;

    private $allowed_types = [];

    public function __construct()
    {
        $this->config = module_config('blog');

        parent::__construct($this->config->post_type);

        $this->allowed_types[] = $this->config->post_type;

        $this->form_action = "module/run/blog/process/";
        $this->posts       = new Posts($this->config->post_type);
        $this->categories  = new \modules\blog\models\Categories($this->config->category_type);
        $this->relations   = new ContentRelationship();

        // hide custom block
//        $this->form_display_blocks['content'] = false;
        $this->form_display_params['parent']   = false;
        $this->form_display_blocks['features'] = false;
    }


    public function init()
    {
        $this->assignToNav('Blog', 'module/run/blog', 'fa-book', null, 30);
        $this->template->assignScript("modules/blog/js/admin/blog.js");

        DataFilter::add
        (
            'nav.items.content_types',
            function($types)
            {
                $types[] = $this->config->category_type;
                return $types;
            }
        );

        EventsHandler::getInstance()->add('content.params', [$this, 'contentParams']);
        EventsHandler::getInstance()->add('content.process', [$this, 'contentProcess']);
        EventsHandler::getInstance()->add('dashboard', [$this, 'dashboard']);
        EventsHandler::getInstance()->add('content.process', [new Tags(), 'process']);
        EventsHandler::getInstance()->add('system.admins.form.after', function($user)
        {
            $this->template->assign('user', $user);
            return $this->template->fetch('modules/blog/admin');
        });
    }

    public function dashboard()
    {
        $this->posts->num = 3;
        $this->template->assign('items', $this->posts->get());
        return $this->template->fetch('modules/blog/dashboard');
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

        return $this->template->fetch('modules/blog/select_categories');
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
                $this->addBreadCrumb($parent['name'], $k<$c ? 'module/run/blog/index/' . $parent['id'] : '' );
            }
        }

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.button_create'),
                ['class' => 'btn-md btn-primary', 'href'=> 'module/run/blog/create' . ($parent_id? "/$parent_id" : '')]
            )
        );

        $t = new DataTables2('content');

        $t  -> ajax('module/run/blog/index/' . $parent_id)
//            ->orderDef(0, 'desc')
            -> th(t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th(t('common.name'), 'ci.name', 1, 1)
            -> th(t('common.created'), 'c.created', 0,1, 'width: 200px')
            -> th(t('common.updated'), 'c.updated', 0, 1, 'width: 200px')
            -> th(t('common.tbl_func'), null, 0, 0, 'width: 180px')
        ;
        $t->get('ci.url',null,null,null);
        $t->get('c.status',null,null,null);
        $t->get('c.isfolder',null,null,null);
        $t->get('CONCAT(u.name, \' \' , u.surname) as owner',null,null,null);


        if($this->request->isXhr()){
            $t  -> from('__content c')
                -> join("__content_types ct on ct.type = '{$this->type}' and ct.id=c.types_id")
                -> join("__content_info ci on ci.content_id=c.id and ci.languages_id={$this->languages->id}")
                -> join('__users u on u.id=c.owner_id')
                -> where("c.status in ('published', 'hidden')");

            if($parent_id > 0){
                $t->join("__content_relationship cr on cr.content_id=c.id and cr.categories_id={$parent_id}");
            }

            $t-> execute();

            $res = array();
//        $comments = new Comments();

            foreach ($t->getResults(false) as $i=>$row) {
                $t_comments_new = 0;//$comments->getTotalNew($row['id']);

                $icon = Icon::create(($row['isfolder'] ? 'fa-folder' : 'fa-file'));
                $icon_link = Icon::create('fa-external-link');
                $status = t($this->type .'.status_' . $row['status']);
                $res[$i][] = $row['id'];
                $res[$i][] =
                    " <a class='status-{$row['status']}' title='{$status}' href='module/run/blog/edit/{$row['id']}'>{$icon}  {$row['name']}</a>"
                    . " <a href='/{$row['url']}' target='_blank'>{$icon_link}</a>"
                    . "<br><small class='label label-info'>Автор:{$row['owner']} </small>"
                    . ($t_comments_new > 0 ? ", <small class='label label-info'>{$t_comments_new} новий</small>" : "")
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
                                'class' => 'btn-primary b-'.$this->type.'-hide',
                                'title' => t('common.title_pub'),
                                'data-id' => $row['id']
                            ]
                        )
                        :
                        Link::create
                        (
                            Icon::create(Icon::TYPE_HIDDEN),
                            [
                                'class' => 'btn-primary b-'.$this->type.'-pub',
                                'title' => t('common.title_hide'),
                                'data-id' => $row['id']
                            ]
                        )
                    ) .
                    (string)Link::create
                    (
                        Icon::create(Icon::TYPE_EDIT),
                        ['class' => 'btn-primary', 'href' => "module/run/blog/edit/" . $row['id'], 'title' => t('common.title_edit')]
                    ) .
                    ($row['isfolder'] == 0 ? (string)Button::create
                    (
                        Icon::create(Icon::TYPE_DELETE),
                        ['class' => 'b-'.$this->type.'-delete btn-danger', 'data-id' => $row['id'], 'title' => t($this->type.'.delete_question')]
                    ) : "")

                ;
            }

            return $t->render($res, $t->getTotal());
        }

        $this->template->assign('sidebar', $this->template->fetch('modules/blog/categories/tree'));
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

        $this->appendToPanel
        (
            (string)Link::create
            (
                t('common.back'),
                ['class' => 'btn-md', 'href'=> 'module/run/blog' . ($parent_id > 0 ? '/index/' . $parent_id : '')]
            )
        );

        $tags = new Tags();
        EventsHandler::getInstance()->add('content.params.after', [$tags, 'index']);

        $this->template->assign('sidebar', $this->template->fetch('modules/blog/categories/tree'));

        parent::edit($id);
    }
}