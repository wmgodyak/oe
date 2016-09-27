<?php
namespace modules\newsletter\controllers\admin\newsletter;

use helpers\bootstrap\Button;
use helpers\bootstrap\Icon;
use system\core\DataFilter;
use system\core\DataTables2;
use system\Engine;

/**
 * Class Subscribers
 * @package modules\newsletter\controllers\admin\newsletter
 */
class Subscribers extends Engine
{
    private $subscribers;

    public function __construct()
    {
        parent::__construct();

        $this->subscribers = new \modules\newsletter\models\admin\Subscribers();
    }

    public function index($group_id = null)
    {
//        for($i=0;$i< 50 ; $i++){
//            $this->subscribers->create(['email' => "somemail{$i}@dot.com"]);
//        }
//        die;

//        $this->appendToPanel
//        (
//            (string)Button::create
//            (
//                $this->t('common.button_create'), ['class' => 'btn-md btn-primary b-newsletter-subscribers-create']
//            )
//        );

        $t = new DataTables2('newsletter_subscribers');

        $t
            -> th("<input style='z-index: 1' type='checkbox' class='dt-check-all'>", null, 0, 0, 'width: 60px')
            -> th($this->t('common.id'), 's.id', true, true)
            -> th('E-mail',       's.email', true, true)
            -> th('Status',      's.status', false, true)
            -> th('Created',    's.created', false, true)
            -> th('Confirm Date', 's.confirmdate', false, true)
            -> th('Ip',          's.ip', true, false)
            -> th('Form',        's.form', false, true)
            -> th($this->t('common.func'), null, false, false)
        ;

        $t-> ajax('module/run/newsletter/subscribers/index/'. $group_id);
        $t->addGroupAction('Copy to group', 'engine.newsletter.subscribers.copyToGroup');
        $t->addGroupAction('Move to group', 'engine.newsletter.subscribers.moveToGroup');
        $t->addGroupAction('Delete selected', 'engine.newsletter.subscribers.deleteSelected');

        if($this->request->isXhr()){

            $t  -> from('__newsletter_subscribers s');

            if($group_id > 0){
                $t->join("__newsletter_subscribers_group_subscribers sgs");
                $t->where("sgs.group_id=$group_id and sgs.subscribers_id=s.id");
            }

            $t  -> execute();

            if(! $t){
                echo $t->getError();
                return null;
            }

            $res = array();
            foreach ($t->getResults(false) as $i=>$row) {

                $row = DataFilter::apply('newsletter.subscribers.list.row', $row);

                $res[$i][] = '<input class=\'dt-chb\' value=\''. $row['id'] .'\' type=\'checkbox\' style=\'height: auto;\'>';
                $res[$i][] = $row['id'];
                $res[$i][] = $row['email'];
                $res[$i][] = $row['status'];
                $res[$i][] = $row['created'];
                $res[$i][] = $row['confirmdate'];
                $res[$i][] = $row['ip'];
                $res[$i][] = $row['form'];

                $b = [];
                /*$b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_EDIT),
                    ['class' => 'b-newsletter-subscribers-edit btn-primary', 'data-id' => $row['id'], 'title' => $this->t('common.title_edit')]
                );*/
                if($row['status'] == 'confirmed'){
                    $b[] =  (string)Button::create
                    (
                        Icon::create(Icon::TYPE_BAN),
                        ['class' => 'b-newsletter-subscribers-ban', 'data-id' => $row['id'], 'title' => $this->t('newsletter.subscribers.title_ban')]
                    );
                }

                $b[] = (string)Button::create
                (
                    Icon::create(Icon::TYPE_DELETE),
                    ['class' => 'b-newsletter-subscribers-delete btn-danger', 'data-id' => $row['id'], 'title' => $this->t('common.title_delete')]
                );

                $res[$i][] = implode('', $b);
            }

            echo $t->render($res, $t->getTotal());die;
        }

        $this->template->assign('sidebar', $this->template->fetch('modules/newsletter/subscribers/groups/tree'));
        $this->template->assign('group_id', $group_id);

        $this->output($t->init() . $this->template->fetch('modules/newsletter/subscribers/groups/bottom_panel'));
    }

    public function deleteSelected()
    {
        $items = $this->request->post('items');
        if(empty($items)) die;

        foreach ($items as $k=>$id) {
            $this->subscribers->delete($id);
        }

        echo $this->subscribers->hasError() ? 0 : 1;
    }

    public function moveToGroup()
    {
        $action = $this->request->post('action');
        if($action){
            $group_id = $this->request->post('group_id');
            foreach ($this->request->post('items') as $k=>$subscribers_id) {
                $this->subscribers->groups_subscribers->delete($group_id, $subscribers_id);
                $this->subscribers->groups_subscribers->create($group_id, $subscribers_id);
            }
            $s = $this->subscribers->hasError() == true ? 0 : 1;
            $this->response->body(['s' => $s])->asJSON();
            return;
        }

        $this->template->assign('items', $this->request->post('items'));
        $this->template->assign('groups', $this->subscribers->groups->get());

        $this->response->body($this->template->fetch('modules/newsletter/subscribers/move_to_group'))->asHtml();
    }

    public function copyToGroup()
    {
        $action = $this->request->post('action');
        if($action){
            $group_id = $this->request->post('group_id');
            foreach ($this->request->post('items') as $k=>$subscribers_id) {
                $this->subscribers->groups_subscribers->create($group_id, $subscribers_id);
            }
            $s = $this->subscribers->hasError() == true ? 0 : 1;
            $this->response->body(['s' => $s])->asJSON();
            return;
        }

        $this->template->assign('items', $this->request->post('items'));
        $this->template->assign('groups', $this->subscribers->groups->get());

        $this->response->body($this->template->fetch('modules/newsletter/subscribers/copy_to_group'))->asHtml();
    }

    public function groups()
    {
        $action = 'index';
        $params = func_get_args();

        if(!empty($params)){
            $action = array_shift($params);
        }

        $controller  = new subscribers\Groups();

        return call_user_func_array(array($controller, $action), $params);
    }

    public function export($group_id = 0)
    {
        $subscribers = $this->subscribers->export($group_id);
        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=subscribers.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        echo "id;email;status;created;confirmdate\n";
        foreach ($subscribers as $fields) {
            echo implode(';', $fields), "\n";
        }
        die;
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        $id = (int)$id;
       echo $this->subscribers->delete($id);
    }

    public function process($id)
    {
        // TODO: Implement process() method.
    }
}