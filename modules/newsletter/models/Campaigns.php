<?php

namespace modules\newsletter\models;

use modules\newsletter\models\campaigns\Queues;
use modules\newsletter\models\subscribers\Meta;
use system\models\Mailer;
use system\models\Model;

class Campaigns extends Model
{
    private $queue;
    private $meta;

    public function __construct()
    {
        parent::__construct();

        $this->queue = new Queues();
        $this->meta = new Meta();
    }

    public function cron()
    {
        $campaign = $this->getActive();
        if(empty($campaign)) return ;

//        d($campaign);die;

        $subscribers = $this->queue->getNotSentSubscribers($campaign['id'], 25);

        if(empty($subscribers)){
            $this->completed($campaign['id']);
            return;
        }

//        d($subscribers);die;
        foreach ($subscribers as $subscriber) {
            if(empty($subscriber['languages_id'])) $subscriber['languages_id'] = $this->languages_id;
            $subscriber['meta'] = $this->meta->get($subscriber['subscribers_id']);
            $mailer = new Mailer(null, $campaign['info'][$subscriber['languages_id']]['subject'], $subscriber);
            if($campaign['smtp'] == 0){
                $mailer->setFrom($campaign['sender_email'], $campaign['sender_name']);
            }
            $mailer->body($campaign['info'][$subscriber['languages_id']]['htmlbody']);
            $mailer->addAddress($subscriber['email']);
            $s = $mailer->send();

            if($s){
                $this->queue->setSent($subscriber['id']);
            }
            sleep(1);
        }
    }

    private function completed($id)
    {
        return parent::updateRow('__newsletter_campaigns', $id, ['status' => 'completed']);
    }

    private function getActive()
    {
        $res = self::$db
            ->select("
                select id, sender_name, sender_email, smtp
                from __newsletter_campaigns
                where status = 'in_progress'
            ")
            ->row();
        if(empty($res)) return null;

        $info = self::$db
            ->select("select languages_id, subject, textbody, htmlbody
                      from  __newsletter_campaigns_info
                      where campaigns_id = {$res['id']}
                      ")
            ->all();

        foreach ($info as $item) {
            $res['info'][$item['languages_id']] = $item;
        }

        return $res;
    }
}