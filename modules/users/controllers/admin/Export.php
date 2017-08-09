<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 18.05.17
 * Time: 18:08
 */

namespace modules\users\controllers\admin;

use system\Backend;

class Export extends Backend
{
    private $users;
    private $usersGroup;

    public function __construct()
    {
        parent::__construct();

        $this->users = new \modules\users\models\Users();
        $this->usersGroup = new \modules\users\models\UsersGroup();
    }

    public function csv($group_id = null)
    {
        if(empty($group_id)) die('Wrong group');

        $subscribers = $this->users->export($group_id);
        header("Content-type: text/csv; charset=windows-1251");
        header("Content-Disposition: attachment; filename=users.csv");
        header("Pragma: no-cache");
        header("Expires: 0");

        echo "id;group_id;name;surname;email;phone;created;status\n";
        foreach ($subscribers as $fields) {
            foreach ($fields as $k=>$v) {
                $fields[$k] = str_replace(';', ',', $v);
            }
            echo implode(';', $fields), "\n";
        }
        die;
    }

    public function index(){}
    public function create(){}
    public function edit($id){}
    public function delete($id){}
    public function process($id){}
}