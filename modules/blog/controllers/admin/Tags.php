<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 28.06.16
 * Time: 11:18
 */

namespace modules\blog\controllers\admin;

use system\Engine;

class Tags extends Engine
{
    private $tags;
    private $posts_tags;

    public function __construct()
    {
        parent::__construct();

        $this->tags       = new \modules\blog\models\Tags();
        $this->posts_tags = new \modules\blog\models\PostsTags();
    }

    public function index($content = null)
    {
        $this->template->assign('posts_tags', $this->posts_tags->get($content['id']));
        return $this->template->fetch('blog/tags');
    }

    public function create($id=0){}

    public function edit($id){}

    public function delete($id){}

    public function process($posts_id)
    {
        $ct = $this->tags->getContentType($posts_id);
        if($ct != 'post') return;

        $tags  = $this->request->post('tags');
        $_tags = $this->posts_tags->get($posts_id);
        if($tags){

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