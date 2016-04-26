<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 18.03.16 : 9:51
 */

namespace controllers\engine\plugins;

use controllers\engine\Plugin;

defined("CPATH") or die();

/**
 * Class Comments
 * @name Comments
 * @icon fa-comments
 * @author Volodymyr Hodiak
 * @version 1.0.0

 * @package controllers\engine
 */
class Comments extends Plugin
{
    private $comments;

    public function __construct()
    {
        parent::__construct();

        $this->disallow_actions = ['index','delete','process'];
        $this->comments = new \models\engine\plugins\Comments();
    }

    public function index(){}

    public function create($id=0)
    {
        $comments = $this->comments->get($id);
        $this->template->assign('comments', $comments);
        $this->template->assign('comments_total', $this->comments->getTotal($id));
        return $this->template->fetch('plugins/comments/index');
    }

    public function edit($id)
    {
        $comments = $this->comments->get($id);
        $this->template->assign('comments', $comments);
        $this->template->assign('comments_total', $this->comments->getTotal($id));
        return $this->template->fetch('plugins/comments/index');
    }

    public function delete($id){}

    public function process($id)
    {
        
    }
}