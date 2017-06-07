<?php

namespace system\models;

use system\core\Template;

include_once DOCROOT . "/vendor/phpmailer/PHPMailer.php";
include_once DOCROOT . "/vendor/phpmailer/SMTP.php";
include_once DOCROOT . "/vendor/phpmailer/POP3.php";

class XMail
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

    private $data;

    private $has_address = false;

    private $tpl;

    private $body;

    private $subject;

    public function __construct($subject, array $data = [], $isHtml = true)
    {
        $this->subject      = $subject;
        $this->phpmailer    = new \PHPMailer();
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
     * @return $this
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
     * @return $this
     */
    public function addReplyTo($address, $name = '')
    {
        $this->phpmailer->addReplyTo($address, $name);

        return $this;
    }

    /**
     * @return $this
     */
    public function clearAddresses()
    {
        $this->has_address = false;
        $this->phpmailer->clearAddresses();

        return $this;
    }

    /**
     * @param $subject
     * @return $this
     */
    public function subject($subject)
    {
        $this->subject = $subject;

        return $this;
    }

    /**
     * @param $body
     * @return $this
     */
    public function body($body)
    {
        $this->body = $body;

        return $this;
    }

    public function template($path)
    {
        $this->tpl = $path;
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
        $this->phpmailer->Subject = $this->subject;

        $app = App::getInstance();

        Template::getInstance()->assign('appurl', APPURL);
        Template::getInstance()->assign('app', $app);
        Template::getInstance()->assign('data', $this->data);

        if(empty($this->tpl) && empty($this->body)){
            throw new \Exception("Empty mail body");
        }

        if(!empty($this->tpl)){
            $body = $template->fetch($this->tpl);
        } else {
            $body = $template->fetchString($this->body);
        }

        $parser = new Parser($body);
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
                throw new \Exception("SMTP is not configured");
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