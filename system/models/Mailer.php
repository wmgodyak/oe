<?php
/**
 * Created by PhpStorm.
 * User: wg
 * Date: 23.06.16
 * Time: 0:42
 */

namespace system\models;

use system\core\DB;
use system\core\exceptions\Exception;
use system\core\Template;

include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";

class Mailer
{
    /**
     * @var \PHPMailer
     */
    private $phpmailer;
    /**
     * template settings
     * @var array|mixed
     */
    private $settings;
    private $languages_id = 0;
    private $data;
    private $has_address = false;

    public function __construct($code, $data = null, $isHtml = true)
    {
        $this->phpmailer    = new \PHPMailer();
        $this->languages_id = 1; // todo change it in future
        $this->data         = $data;

        $this->settings['name']          = Settings::getInstance()->get('mail_from_name');
        $this->settings['from']          = Settings::getInstance()->get('mail_email_from');
        $this->settings['to']            = Settings::getInstance()->get('mail_email_to');
        $this->settings['smtp_on']       = Settings::getInstance()->get('mail_smtp_on');
        $this->settings['smtp_host']     = Settings::getInstance()->get('mail_smtp_host');
        $this->settings['smtp_port']     = Settings::getInstance()->get('mail_smtp_port');
        $this->settings['smtp_user']     = Settings::getInstance()->get('mail_smtp_user');
        $this->settings['smtp_password'] = Settings::getInstance()->get('mail_smtp_password');
        $this->settings['smtp_secure']   = Settings::getInstance()->get('mail_smtp_secure');

        $this->phpmailer->isHTML($isHtml);
        $this->phpmailer->CharSet="UTF-8";

        if(strlen($code) <= 30){
            $this->setTemplate($code);
        } else{
            $this->setBody($code);
        }
        $this->clearAddresses();
    }

    public function setTemplate($code)
    {
        $template = DB::getInstance()
            ->select("
                select i.subject, i.body
                from __mail_templates t
                join __mail_templates_info i on i.templates_id=t.id and i.languages_id='{$this->languages_id}'
                where t.code = '{$code}'
                limit 1
              ")
            ->row();

        if(empty($template)){
            throw new Exception("Wrong template code $code");
        }

        $this->settings['subject'] = $template['subject'];

        $header                    = Settings::getInstance()->get('mail_header');
        $footer                    = Settings::getInstance()->get('mail_footer');
        $this->settings['body']    = $header . $template['body'] . $footer;

        return $this;
    }

    public function setBody($body)
    {
        $header                 = Settings::getInstance()->get('mail_header');
        $footer                 = Settings::getInstance()->get('mail_footer');
        $this->settings['body'] = $header . $body . $footer;

        return $this;
    }

    /**
     * @param $address
     * @param string $patternselect
     * @return bool
     */
    public static function validateAddress($address, $patternselect = 'auto')
    {
        return \PHPMailer::validateAddress($address, $patternselect);
    }

    /**
     * @param $address
     * @param string $name
     * @param bool|true $auto
     * @return bool
     * @throws \phpmailerException
     */
    private function setFrom($address, $name = '', $auto = true)
    {
        return $this->phpmailer->setFrom($address, $name, $auto);
    }

    /**
     * @param $address
     * @param string $name
     * @return bool
     */
    public function addAddress($address, $name = '')
    {
        if(strpos($address, ',')){
            $a = explode(',', $address);
            foreach ($a as $k=>$e) {
                $this->phpmailer->addAddress($e, $name);
            }
        } else {
            $this->phpmailer->addAddress($address, $name);
        }

        return $this;
    }

    /**
     * @param $address
     * @param string $name
     * @return bool
     */
    private function addReplyTo($address, $name = '')
    {
        $this->phpmailer->addReplyTo($address, $name);

        return $this;
    }

    public function clearAddresses()
    {
        $this->phpmailer->clearAddresses();

        return $this;
    }

    /**
     * @return bool
     * @throws \Exception
     * @throws \phpmailerException
     */
    public function send()
    {
        //add subject
        $this->phpmailer->Subject = $this->settings['subject'];

        // add body
        if(empty($this->settings['body'])){
            throw new Exception('Empty body. Set template with method $mailer->setTemplate(tpl_code); or $mailer->setBody(custom body);');
        }

        Template::getInstance()->assign('data', $this->data);
        $this->phpmailer->Body = Template::getInstance()->fetchString($this->settings['body']);

        // add address

        if(! $this->has_address){
            // to admin
            $this->addAddress($this->settings['to']);
        }

        if($this->settings['smtp_on'] == 0) {
            $this->setFrom($this->settings['from'], $this->settings['name']);
        }

        if($this->settings['smtp_on'] == 1){
            if(
                empty($this->settings['smtp_host']) ||
                empty($this->settings['smtp_port']) ||
                empty($this->settings['smtp_user']) ||
                empty($this->settings['smtp_password']) ||
                empty($this->settings['smtp_secure'])
            ) {
                throw new Exception("Налаштуйте SMTP");
            }


            $this->phpmailer->IsSMTP();
            $this->phpmailer->SMTPSecure = $this->settings['smtp_secure'];
            $this->phpmailer->Host       = $this->settings['smtp_host'];
            $this->phpmailer->Port       = $this->settings['smtp_port'];
            $this->phpmailer->Username   = $this->settings['smtp_user'];
            $this->phpmailer->Password   = $this->settings['smtp_password'];
            $this->phpmailer->SMTPAuth   = true;

            $this->setFrom($this->settings['smtp_user'], $this->settings['from']);
        }

        return $this->phpmailer->send();
    }

    public function getErrorInfo()
    {
        return $this->phpmailer->ErrorInfo;
    }

}