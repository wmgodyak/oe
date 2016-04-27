<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 27.04.16 : 10:50
 */

namespace controllers\modules;

use controllers\App;
use controllers\core\Session;

defined("CPATH") or die();

class AdminPanel extends App
{
    public function index()
    {
        $user = Session::get('engine.admin');

        echo "<div class='admin-panel'><div class='cnt'>";
        echo "Вітаємо, {$user['name']}. ";
        if(Session::get('inline_editing')){
            echo "<a href='javascript:;' class='admin-panel-disable-editing'>Редагування увімкнуто.</a>";
        } else {
            echo "<a title='Увімкнути режим редагування інлайн' href='javascript:;' class='admin-panel-enable-editing'>Редагування вимкнуто.</a>";
        }

        echo " | <a href='javascript:;' class='admin-panel-logout'>Вийти</a>";
        echo "</div></div>
        ";
    }

    public function enableEditing()
    {
        Session::set('inline_editing', true);die;
    }

    public function disableEditing()
    {
        Session::delete('inline_editing');die;
    }

    public function updateContent()
    {
        $id   = $this->request->post('id','i');
        $data = $this->request->post('editabledata');
        $col  = $this->request->post('editorID', 's');
        $col  = str_replace('ce_','', $col);
        $col  = str_replace('cms_','', $col);

        if(empty($id) || empty($col) || !in_array($col, ['name','h1', 'description', 'content'])) {
            echo 'Not Allowed';
            return;
        }

        $ap = new \models\app\AdminPanel();
        $s  = $ap->updateContent($id, $col, $data);
        if($ap->hasDBError()){
            echo $ap->getDBErrorMessage();
        }
        echo $s;die;
    }
}