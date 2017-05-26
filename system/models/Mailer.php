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
    private $tpl  = null;
    private $body = null;

    public function __construct($tpl, $subject, $data = null, $isHtml = true)
    {
        $this->tpl = $tpl;
        $this->settings['subject'] = $subject;
        $this->phpmailer    = new \PHPMailer();
        $this->languages->id = 1; // todo change it in future
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

        $this->clearAddresses();
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
    public function setFrom($address, $name = '', $auto = true)
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
        $this->has_address = true;
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
    public function addReplyTo($address, $name = '')
    {
        $this->phpmailer->addReplyTo($address, $name);

        return $this;
    }

    public function clearAddresses()
    {
        $this->phpmailer->clearAddresses();

        return $this;
    }

    public function body($body)
    {
        $this->body = $body;

        return $this;
    }

    /**
     * @return bool
     * @throws \Exception
     * @throws \phpmailerException
     */
    public function send()
    {
        $template = Template::getInstance();
        //add subject
        $this->phpmailer->Subject = $this->settings['subject'];

        $header = Settings::getInstance()->get('mail_header');
        $footer = Settings::getInstance()->get('mail_footer');

        $app_cl = App::getInstance();

        Template::getInstance()->assign('appurl', APPURL);
        Template::getInstance()->assign('app', $app_cl);
        Template::getInstance()->assign('data', $this->data);

        if($header != ''){
            $header = $template->fetch($header);
        }
        if($footer != ''){
            $footer = $template->fetch($footer);
        }

        if(empty($this->tpl) && empty($this->body)){
            throw new Exception("Empty mail body");
        }

        if(empty($this->tpl)){
            $body = $template->fetchString($this->body);
        } else {
            $body = $template->fetch($this->tpl);
        }

        $parser = new Parser($header . $body . $footer);
        $parser->makeFriendlyUrl();
        $this->phpmailer->Body = $parser->getDocumentSource();

        // add address

        if(! $this->has_address){
            // to admin
            $this->addAddress($this->settings['to']);
        }

        if($this->settings['smtp_on'] == 0 && empty($this->settings['from'])) {
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