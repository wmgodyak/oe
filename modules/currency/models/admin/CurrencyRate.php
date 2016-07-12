<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 12.07.16
 * Time: 20:16
 */

namespace modules\currency\models\admin;

use system\models\Model;

class CurrencyRate extends Model
{
    public function getOldCurrencies($id = null)
    {
        $where = $id ? " where id <> {$id}" : null;
        return self::$db->select("select id, code from __currency {$where}")->all();
    }

    /**
     * @param $currency_id
     * @throws \system\core\exceptions\Exception
     */
    public function update($currency_id)
    {
        $rate = $this->request->post('rate');
        if(! $rate) return;

        foreach ($rate as $to_currency_id => $value) {
            $id = self::$db
                ->select("
                    select id
                    from __currency_rate
                    where currency_id = {$currency_id} and to_currency_id={$to_currency_id}
                    limit 1
                ")->row('id');

            if(empty($id)){
                $this->createRow
                (
                    '__currency_rate',
                    ['currency_id' => $currency_id, 'to_currency_id' => $to_currency_id, 'rate' => $value]
                );
            } else {
                $this->updateRow('__currency_rate', $id, ['rate' => $value]);
            }

            if($this->hasError()){
                return;
            }
        }
    }

    /**
     * @param $currency_id
     * @return array
     * @throws \system\core\exceptions\Exception
     */
    public function get($currency_id)
    {
        $r = self::$db
            ->select("select to_currency_id, rate from __currency_rate where currency_id={$currency_id}")
            ->all();

        $res = [];
        foreach ($r as $row) {
            $res[$row['to_currency_id']] = $row['rate'];
        }

        return $res;
    }
}