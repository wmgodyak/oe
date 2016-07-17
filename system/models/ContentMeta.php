<?php

namespace system\models;
/**
 * Class ContentMeta
 * @package system\models
 */
class ContentMeta extends Model
{
    /**
     * @param $content_id
     * @param $meta_k
     * @param $meta_v
     * @return bool|string
     */
    public function create($content_id, $meta_k, $meta_v)
    {
        return $this->createRow
        (
            '__content_meta',
            [
                'content_id' => $content_id,
                'meta_k'     => $meta_k,
                'meta_v'     => is_array($meta_v) ? serialize($meta_v) : $meta_v
            ]
        );
    }

    /**
     * @param $content_id
     * @param $meta_k
     * @param $meta_v
     * @param null $id
     * @return bool|string
     * @throws \system\core\exceptions\Exception
     */
    public function update($content_id, $meta_k, $meta_v, $id = null)
    {
        if( ! $id){
            $id = self::$db
                ->select("select id from __content_meta where content_id={$content_id} and meta_k = '{$meta_k}' limit 1")
                ->row('id');
        }

        if($id){
           return $this->updateRow('__content_meta', $id, ['meta_v' => is_array($meta_v) ? serialize($meta_v) : $meta_v]);
        } else {
           return $this->create($content_id, $meta_k, $meta_v);
        }
    }

    /**
     * @param $content_id
     * @param null $meta_k
     * @param null $id
     * @return int
     * @throws \system\core\exceptions\Exception
     */
    public function delete($content_id, $meta_k = null, $id = null)
    {
        if($id){
            return $this->deleteRow('__content_meta', $id);
        }

        if($meta_k){
            return self::$db->delete("__content_meta", "content_id='{$content_id} and meta_k='{$meta_k}' ");
        }

        return self::$db->delete("__content_meta", "content_id='{$content_id}");
    }

    /**
     * @param $content_id
     * @param null $meta_k
     * @param bool $single
     * @return array|mixed|null
     * @throws \system\core\exceptions\Exception
     */
    public function get($content_id, $meta_k = null, $single = false)
    {
        $meta_v = null;

        if($meta_k){
            if($single){
                $meta_v = self::$db
                    ->select("select meta_v from __content_meta where content_id='{$content_id}' and meta_k='{$meta_k}' limit 1")
                    ->row('meta_v');
                if(isSerialized($meta_v)) $meta_v = unserialize($meta_v);
            } else {
                $r = self::$db
                    ->select("select id, meta_v from __content_meta where content_id='{$content_id}' and meta_k='{$meta_k}'")
                    ->all();
                foreach ($r as $row) {
                    $meta_v[$row['id']] = (isSerialized($row['meta_v'])) ? unserialize($row['meta_v']) : $row['meta_v'];
                }
            }
        } else {
            $r = self::$db
                ->select("select id, meta_k, meta_v from __content_meta where content_id='{$content_id}'")
                ->all();
            foreach ($r as $row) {
                if(! isset($meta_v[$row['meta_k']])) $meta_v[$row['meta_k']] = [];
                $meta_v[$row['meta_k']][$row['id']] = (isSerialized($row['meta_v'])) ? unserialize($row['meta_v']) : $row['meta_v'];
            }
        }

        return $meta_v;
    }
}