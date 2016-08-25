<?php
/**
 * Created by PhpStorm.
 * User: user
 * Date: 22.07.16
 * Time: 17:17
 */
namespace modules\gmap\models\admin;

defined('CPATH') or die();

/**
 * Class Gmap
 * @package modules\gmap\models\admin
 */
class Gmap extends \modules\gmap\models\Gmap
{

    public function create($data,$info)
    {
        $id = self::$db->insert('__gps',$data);

        if($id) {

            foreach ($info as $languages_id=>$value) {
                self::$db->insert('__gps_info',array(
                    'gps_id'=>$id,
                    'e_languages_id'=>$languages_id,
                    'name'=>$value['name']
                ));
            }
        }

//        return $id;
    }

    public function get()
    {
        return self::$db->select("
                Select g.*,i.name from __gps g
                join __gps_info i on g.id=i.gps_id and i.e_languages_id={$this->languages_id}
                ORDER by abs(g.id)
            ")->all();
    }

    public function getField($id, $field ,$l=null)
    {
        if (!empty($l)) {$w = 'and i.e_languages_id='.$l;} else {$w = '';}

        return self::$db->select("
                select {$field} from __gps g
                join __gps_info i on g.id=i.gps_id $w
                where g.id = {$id}
            ")->row($field);
    }

    public function delete($id)
    {
        return $this->deleteRow('__gps', $id);
    }

    public function update($id, $data, $info)
    {
        if (empty($id) || empty($data) || empty($info)) return false;
        $s = $this->updateRow('__gps', $id, $data);

        foreach ($info as $language_id=>$item) {
//             d($item);
            self::$db->update("__gps_info",array(
                'name'=>$item['name']
            )," gps_id={$id} and e_languages_id={$language_id}");
        }
    }

}