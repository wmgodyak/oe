<?php

namespace modules\hybridAuth\models;

use system\models\Model;

/**
 * Class HybridAuth
 * @package modules\hybridAuth\models
 */
class HybridAuth extends Model
{
    /**
     * @param $users_id
     * @param $provider
     * @param $profile_id
     * @param $meta
     * @return bool|string
     */
    public function create($users_id, $provider, $profile_id, $meta)
    {
        $meta = serialize($meta);
        return $this->createRow
        (
            '__users_hybridauth',
            ['provider' => $provider, 'profile_id' => $profile_id, 'users_id' => $users_id, 'meta' => $meta]
        );
    }
    /**
     * @param $provider
     * @param $profile_id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function auth($provider, $profile_id)
    {
        return self::$db
            ->select("select id from __users_hybridauth where provider = '{$provider}' and profile_id='{$profile_id}' limit 1")
            ->row('id');
    }

    /**
     * @param $id
     * @return array|mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getUsersId($id)
    {
        return self::$db
            ->select("select users_id from __users_hybridauth where id={$id} limit 1")
            ->row('users_id');
    }

    /**
     * @param $id
     * @return mixed
     * @throws \system\core\exceptions\Exception
     */
    public function getMeta($id)
    {
        $meta = self::$db
            ->select("select meta from __users_hybridauth where id={$id} limit 1")
            ->row('meta');

        return unserialize($meta);
    }

}