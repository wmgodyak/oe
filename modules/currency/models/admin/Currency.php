<?php

namespace modules\currency\models\admin;


class Currency extends \modules\currency\models\Currency
{
    /**
     * @param $data
     * @return bool|string
     */
    public function create()
    {
        $data = $this->request->post('data');

        $id = $this->createRow('__currency', $data);

        if($id>0 && $data['is_main']) {
            $this->toggleMain($id);
        }
        if($id > 0 && $data['on_site']) {
            $this->toggleOnSite($id);
        }

        return $id;
    }

    /**
     * @param $id
     * @return bool
     */
    public function update($id)
    {
        $data = $this->request->post('data');
        $s = $this->updateRow('__currency', $id, $data);

        if($data['is_main']) {
            $this->toggleMain($id);
        }
        if($data['on_site']) {
            $this->toggleOnSite($id);
        }

        return $s;
    }

    public function delete($id)
    {
        return self::$db->delete('__currency', " id={$id} limit 1");
    }

    private function toggleMain($currency_id)
    {
        self::$db->update('__currency',['is_main' => 0]);
        return $this->updateRow('__currency', $currency_id, ['is_main' => 1]);
    }

    private function toggleOnSite($currency_id)
    {
        self::$db->update('__currency',['on_site' => 0]);
        return $this->updateRow('__currency', $currency_id, ['on_site' => 1]);
    }
}