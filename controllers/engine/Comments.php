<?php
/**
 * OYiEngine 6.x
 * Company Otakoyi.com
 * Author wmgodyak mailto:wmgodyak@gmail.com
 * Date: 13.07.14 9:57
 */

namespace controllers\engine;
use controllers\Engine;
use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use helpers\DateTime;
use helpers\FormValidation;

defined('CPATH') or die();

/**
 * Class Comments
 * @name Коментарі
 * @icon fa-comments
 * @author Volodymyr Hodiak
 * @version 1.0.0
 * @position 5

 * @package controllers\engine
 */
class Comments extends Engine {

    private $mComments;

    public function __construct()
    {
        parent::__construct();

        $this->mComments = new \models\engine\Comments();
    }

    public function index()
    {
//        $this->appendToPanel((string)Button::create($this->t('common.button_create'), ['class' => 'btn-md b-comments-create']));
       $this->output($this->template->fetch('comments/index'));
    }

    /**
     * @param $status
     */
    public function tab($status)
    {
        $t = new DataTables2('comments_' . $status);

        $t
            -> th($this->t('common.id'), 'c.id', 1, 1, 'width: 60px')
            -> th($this->t('comments.pib'), 'u.surname', 1, 1, 'width: 200px')
            -> th($this->t('comments.message'), 'c.message')
            -> th($this->t('comments.created'), 'c.created', 1, 1, 'width: 160px')
            -> th($this->t('common.tbl_func'), null, 0, 0, 'width: 140px')
            ->get('u.id as user_id')
            ->get('u.name')
            ->get('u.email')
            ->get('ci.name as page_name')
            ->get('ci.url')
            ->get('c.skey')
            ->get('c.status')
            -> ajax('comments/items/'  .$status)
            -> orderDef(1, 'desc')
        ;

        $this->output($t->init());
    }

    /**
     * @param $status
     * @return string
     */
    public function items($status)
    {
        $t = new DataTables2();
        $t  -> from('__comments c')
            -> join("__users u on u.id = c.users_id")
            -> join("__content_info ci on ci.content_id=c.content_id and ci.languages_id={$this->languages_id}");


            if($status != 'all'){
                $t-> where(" c.status='{$status}'");
            }

            $t-> execute();
        $res = array();
        foreach ($t->getResults(false) as $i=>$row) {
            $row['url'] = APPURL . $row['url'] . "#comment-{$row['id']}";
            $status = $this->t('comments.status_' . $row['status']);

            $res[$i][] = $row['id'];
            $res[$i][] = $row['surname'] .' '. $row['name'] . "<br><small>{$row['email']}</small>";
            $res[$i][] = "<small>{$row['message']}</small>
                           <br><strong class='label label-{$row['status']}'>{$status}</strong> Для <a target='_blank' href='{$row['url']}'>{$row['page_name']}</a>
                        ";
            $res[$i][] = DateTime::ago(strtotime($row['created']));

            $b = [];
            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_REPLY),
                ['class' => 'b-comments-reply', 'data-id' => $row['id'], 'title' => $this->t('common.title_reply')]
            );
            if($row['status'] == 'new'){
                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_PUBLISHED),
                    ['class' => 'b-comments-approve', 'data-id' => $row['skey'], 'title' => $this->t('comments.title_approve')]
                );

                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_BAN),
                    ['class' => 'b-comments-spam', 'data-id' => $row['id'], 'title' => $this->t('comments.title_spam')]
                );

            } elseif($row['status'] == 'spam'){

                $b[] =  (string)Button::create
                (
                    Icon::create(Icon::TYPE_RESTORE),
                    ['class' => 'b-comments-restore', 'data-id' => $row['id'], 'title' => $this->t('comments.title_restore')]
                );
            }

            $b[] = (string)Button::create
            (
                Icon::create(Icon::TYPE_DELETE),
                ['class' => 'b-comments-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
            );

            $res[$i][] = implode('', $b);
        }

        return $t->render($res, $t->getTotal());
    }

    public function create()
    {
//        $this->template->assign('action', 'create');
//        $this->response->body($this->template->fetch('comments/form'))->asHtml();
    }
    public function edit($id)
    {

    }

    public function reply($id)
    {
        $this->template->assign('data', $this->mComments->getData($id));
        $this->response->body($this->template->fetch('comments/form'))->asHtml();
    }

    public function process($id= null)
    {
        if(! $this->request->isPost()) die;

        $data = $this->request->post('data');
        $reply = $this->request->post('reply');
        $s=0; $i=[];

        FormValidation::setRule(['message'], FormValidation::REQUIRED);
        FormValidation::run($data);

        if(FormValidation::hasErrors()){
            $i = FormValidation::getErrors();
        } else {

            FormValidation::setRule(['message','content_id', 'users_id', 'status'], FormValidation::REQUIRED);
            FormValidation::run($reply);
            if(FormValidation::hasErrors()){
                $i = FormValidation::getErrors();
            } else {
                $s += $this->mComments->update($id, $data);
                $s += $this->mComments->create($reply);
            }
        }

        if(!$s && $this->mComments->hasDBError()){
            echo $this->mComments->getDBErrorMessage();
        }

        $this->response->body(['s'=>$s, 'i' => $i])->asJSON();
    }

    public function approve($id)
    {
        return $this->mComments->approve($id);
    }

    public function delete($id)
    {
        return $this->mComments->delete($id);
    }

    public function spam($id)
    {
        return $this->mComments->spam($id);
    }
    public function restore($id)
    {
        return $this->mComments->restore($id);
    }
}
