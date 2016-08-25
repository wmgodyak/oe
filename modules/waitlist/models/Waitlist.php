<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 23:12
 */

namespace modules\waitlist\models;

use system\core\Session;
use system\models\Model;

/**
 * Class Waitlist
 * @package modules\waitlist\models
 */
class Waitlist extends Model
{
    public function create($data)
    {
        return parent::createRow('__waitlist', $data);
    }

    /**
     * @param $id
     * @param string $key
     * @return array|mixed
     */
    public function getData($id, $key= '*')
    {
        return self::$db->select("select {$key} from __waitlist where id={$id} limit 1")->row($key);
    }

    public function delete($id)
    {
        return $this->deleteRow('__waitlist', $id);
    }
}