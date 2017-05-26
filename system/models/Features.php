<?php
namespace system\models;
/**
 * Class Features
 * @package system\models
 */
class Features extends Backend
{
    public function __construct()
    {
        parent::__construct();

        $this->languages = new Languages();

        $this->languages->id = $this->languages->getDefault('id');
    }

    public function createBlank($parent_id, $owner_id)
    {
        self::$db->delete("__features", " status='blank' and owner_id={$owner_id}");
        return $this->createRow(
            '__features',
            [
                'parent_id' => $parent_id,
                'owner_id'  => $owner_id,
                'code'      => 'feature_' . time()
            ]
        );
    }

    public function getData($id, $key = '*')
    {
        $data = self::$db->select("select {$key} from __features where id={$id} limit 1")->row($key);

        if ($key != '*') return $data;

        foreach ($this->languages->get() as $language) {
            $data['info'][$language['id']] =
                self::$db
                    ->select("select * from __features_info where features_id={$id} and languages_id={$language['id']} limit 1")
                    ->row();
        }

        $data['statuses'] = self::$db->enumValues('__features', 'status');
        $data['types'] = self::$db->enumValues('__features', 'type');

        foreach ($data['types'] as $k => $type) {
            if ($type == 'value') {
                unset($data['types'][$k]);
            }
        }

        return $data;
    }

    public function getName($id)
    {
        return self::$db
            ->select("select name from __features_info where features_id={$id} and languages_id = {$this->languages->id} limit 1")
            ->row('name');
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();
        $this->updateRow('__features', $id, $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $aid = self::$db
                ->select("select id from __features_info where features_id={$id} and languages_id={$languages_id} limit 1")
                ->row('id');
            if(empty($aid)){
                $item['languages_id']    = $languages_id;
                $item['features_id'] = $id;
                $this->createRow('__features_info', $item);
            } else {
                $this->updateRow('__features_info', $aid, $item);
            }
        }
        if($this->hasError()){
            $this->rollback();
            return false;
        }

        if(isset($data['parent_id']) && $data['parent_id'] > 0){
            $this->updateRow('__features', $data['parent_id'], ['type' => 'folder']);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }

    public function delete($id)
    {
        if($this->getData($id, 'type') == 'folder') return false;

        $s = $this->deleteRow('__features', $id);
        if($s){
            self::$db->delete('__features', "parent_id={$id}");
        }
        return $s;
    }

    /**
     * @param $id
     * @return bool
     */
    public function pub($id)
    {
        return $this->updateRow('__features', $id, ['status' => 'published']);
    }

    /**
     * @param $id
     * @return bool
     */
    public function hide($id)
    {
        return $this->updateRow('__features', $id, ['status' => 'hidden']);
    }

    /*
     * Features Values
     *
     */

    /**
     * @param $owner_id
     * @return bool
     */
    public function createValue($owner_id)
    {
        $data = $this->request->post('data');
        $info = $this->request->post('info');

        $this->beginTransaction();

        $data['owner_id'] = $owner_id;
        if(!isset($data['code']) || empty($data['code'])){
            $data['code'] = md5($owner_id . 'x' . microtime());
        }
        $id = $this->createRow('__features', $data);

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        foreach ($info as $languages_id=> $item) {
            $item['languages_id'] = $languages_id;
            $item['features_id']  = $id;
            $this->createRow('__features_info', $item);
        }

        if($this->hasError()){
            $this->rollback();
            return false;
        }

        $this->commit();

        return true;
    }
}