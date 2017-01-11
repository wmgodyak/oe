<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.06.16 : 17:38
 */


namespace system\components\features\models;


defined("CPATH") or die();

class FeaturesContent extends \system\models\FeaturesContent
{


    public function selectContent($features_id)
    {
        $data = [];
        $data['features_id']         = $features_id;
        $data['content_types_id']    = $this->request->post('content_types_id', 'i');
        $data['content_subtypes_id'] = $this->request->post('content_subtypes_id', 'i');

        $c = $this->request->post('content_id');
        if($c){
            foreach ($c as $k=>$content_id) {
                $content_id = (int)$content_id;
                if(empty($content_id)) continue;

                $data['content_id'] = $content_id;
                $this->create($data);
            }
        } else {
            $this->create($data);
        }

        return ! $this->hasError();
    }

    /**
     * @param $features_id
     * @return mixed
     */
    public function getSelectedContent($features_id)
    {
        $res = [];
        foreach ($this->get($features_id) as $row) {
            $row['type'] = $this->getTypeName($row['content_types_id']);
            $row['subtype'] = 'Всі';
            $row['content'] = 'Всі';

            if($row['content_subtypes_id'] > 0){
                $row['subtype'] = $this->getTypeName($row['content_subtypes_id']);
            }

            if($row['content_id'] > 0){
                $row['content'] = $this->getContentName($row['content_id']);
            }

            $res[] = $row;
        }
        return $res;
    }
}