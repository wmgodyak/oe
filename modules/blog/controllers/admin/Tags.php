<?php

namespace modules\blog\controllers\admin;

use system\Backend;

class Tags extends Backend
{
    private $tags;
    private $posts_tags;
    private $config;

    public function __construct()
    {
        parent::__construct();

        $this->config = module_config('blog');

        $this->tags       = new \modules\blog\models\Tags();
        $this->posts_tags = new \modules\blog\models\PostsTags();
    }

    public function index($content = null)
    {
        $this->template->assign('posts_tags', $this->posts_tags->get($content['id']));
        return $this->template->fetch('modules/blog/tags');
    }

    public function create($id=0){}

    public function edit($id){}

    public function delete($id){}

    public function process($posts_id)
    {
        $ct = $this->tags->getContentType($posts_id);

        if($ct != $this->config->post_type) return;

        $tags  = $this->request->post('tags');
        if($tags){
            $_tags = $this->posts_tags->get($posts_id);

            foreach ($tags as $languages_id => $str) {
                $tc = isset($_tags[$languages_id]) ? $_tags[$languages_id] : [];
                $a  = explode(',', $str);
                foreach ($a as $k=>$tag) {
                    $tag = strip_tags($tag);
                    $tag = trim($tag);

                    if(empty($tag)) continue;

                    $tags_id = $this->tags->getId($tag);

                    if(empty($tags_id)){
                        $tags_id = $this->tags->create($tag);
                    }

                    $this->posts_tags->create($tags_id, $posts_id, $languages_id);

                    if(isset($tc[$tags_id])) {
                        unset($tc[$tags_id]);
                    }
                }

                // видалю непотрібні
                if(! empty($tc)){
                    foreach ($tc as $tags_id=>$tag) {
                        $this->posts_tags->delete($tags_id, $posts_id);
                        $t = $this->posts_tags->getTotal($tags_id);
                        if($t == 0){
                            $this->tags->delete($tags_id);
                        }
                    }
                }
            }
        }
    }
}