<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 29.12.15 : 12:04
 */

namespace helpers;

defined('CPATH') or die();

/**
 * Class FormValidation
 * @package helpers
 */
class FormValidation
{
    const REQUIRED = 'required';
    const EMAIL    = 'email';

    private static $rules = [];
    private static $errors = [];

    private static $messages =
        [
            'required' => "Це поле обов'язкове",
            'remote'   => "Будь ласка, перевірте це поле",
            'email'    => "Введіть коректну електронну скриньку"
        ];

    /**
     * @param $input
     * @param $rule
     */
    public static function setRule($input, $rule)
    {
        if(is_array($input)){
            foreach ($input as $k=>$v) {
                self::$rules[] = [$v, $rule];
            }
            return;
        }
        self::$rules[] = [$input, $rule];
    }

    /**
     * @return bool
     */
    public static function hasErrors()
    {
        return !empty(self::$errors);
    }

    /**
     * @return array
     */
    public static function getErrors()
    {
        return self::$errors;
    }

    public static function run($data)
    {
        if(empty(self::$rules)){
            throw new \Exception('Немає що валідувати. Додайте правила. FormValidation::setRule($input, $rule)');
        }

        foreach (self::$rules as $input => $rule) {
            switch($rule){
                case self::REQUIRED:
                    if(empty($data[$input])){
                        self::$errors[] = ["data[{$input}]" => self::$messages['required']];
                    }
                    break;
                case self::EMAIL:
                    //Check this constant first so it works when extension_loaded() is disabled by safe mode
                    //Constant was added in PHP 5.2.4
                    if (defined('PCRE_VERSION')) {
                        //This pattern can get stuck in a recursive loop in PCRE <= 8.0.2
                        if (version_compare(PCRE_VERSION, '8.0.3') >= 0) {
                            $patten = 'pcre8';
                        } else {
                            $patten = 'pcre';
                        }
                    } elseif (function_exists('extension_loaded') and extension_loaded('pcre')) {
                        //Fall back to older PCRE
                        $patten = 'pcre';
                    } else {
                        //Filter_var appeared in PHP 5.2.0 and does not require the PCRE extension
                        if (version_compare(PHP_VERSION, '5.2.0') >= 0) {
                            $patten = 'php';
                        } else {
                            $patten = 'noregex';
                        }
                    }
                    $valid = false;
                        switch ($patten) {
                            case 'pcre8':
                                /**
                                 * Uses the same RFC5322 regex on which FILTER_VALIDATE_EMAIL is based, but allows dotless domains.
                                 * @link http://squiloople.com/2009/12/20/email-address-validation/
                                 * @copyright 2009-2010 Michael Rushton
                                 * Feel free to use and redistribute this code. But please keep this copyright notice.
                                 */
                                $valid = (boolean)preg_match(
                                    '/^(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){255,})(?!(?>(?1)"?(?>\\\[ -~]|[^"])"?(?1)){65,}@)' .
                                    '((?>(?>(?>((?>(?>(?>\x0D\x0A)?[\t ])+|(?>[\t ]*\x0D\x0A)?[\t ]+)?)(\((?>(?2)' .
                                    '(?>[\x01-\x08\x0B\x0C\x0E-\'*-\[\]-\x7F]|\\\[\x00-\x7F]|(?3)))*(?2)\)))+(?2))|(?2))?)' .
                                    '([!#-\'*+\/-9=?^-~-]+|"(?>(?2)(?>[\x01-\x08\x0B\x0C\x0E-!#-\[\]-\x7F]|\\\[\x00-\x7F]))*' .
                                    '(?2)")(?>(?1)\.(?1)(?4))*(?1)@(?!(?1)[a-z0-9-]{64,})(?1)(?>([a-z0-9](?>[a-z0-9-]*[a-z0-9])?)' .
                                    '(?>(?1)\.(?!(?1)[a-z0-9-]{64,})(?1)(?5)){0,126}|\[(?:(?>IPv6:(?>([a-f0-9]{1,4})(?>:(?6)){7}' .
                                    '|(?!(?:.*[a-f0-9][:\]]){8,})((?6)(?>:(?6)){0,6})?::(?7)?))|(?>(?>IPv6:(?>(?6)(?>:(?6)){5}:' .
                                    '|(?!(?:.*[a-f0-9]:){6,})(?8)?::(?>((?6)(?>:(?6)){0,4}):)?))?(25[0-5]|2[0-4][0-9]|1[0-9]{2}' .
                                    '|[1-9]?[0-9])(?>\.(?9)){3}))\])(?1)$/isD',
                                    $data[$input]
                                );
                                break;
                            case 'pcre':
                                //An older regex that doesn't need a recent PCRE
                                $valid = (boolean)preg_match(
                                    '/^(?!(?>"?(?>\\\[ -~]|[^"])"?){255,})(?!(?>"?(?>\\\[ -~]|[^"])"?){65,}@)(?>' .
                                    '[!#-\'*+\/-9=?^-~-]+|"(?>(?>[\x01-\x08\x0B\x0C\x0E-!#-\[\]-\x7F]|\\\[\x00-\xFF]))*")' .
                                    '(?>\.(?>[!#-\'*+\/-9=?^-~-]+|"(?>(?>[\x01-\x08\x0B\x0C\x0E-!#-\[\]-\x7F]|\\\[\x00-\xFF]))*"))*' .
                                    '@(?>(?![a-z0-9-]{64,})(?>[a-z0-9](?>[a-z0-9-]*[a-z0-9])?)(?>\.(?![a-z0-9-]{64,})' .
                                    '(?>[a-z0-9](?>[a-z0-9-]*[a-z0-9])?)){0,126}|\[(?:(?>IPv6:(?>(?>[a-f0-9]{1,4})(?>:' .
                                    '[a-f0-9]{1,4}){7}|(?!(?:.*[a-f0-9][:\]]){8,})(?>[a-f0-9]{1,4}(?>:[a-f0-9]{1,4}){0,6})?' .
                                    '::(?>[a-f0-9]{1,4}(?>:[a-f0-9]{1,4}){0,6})?))|(?>(?>IPv6:(?>[a-f0-9]{1,4}(?>:' .
                                    '[a-f0-9]{1,4}){5}:|(?!(?:.*[a-f0-9]:){6,})(?>[a-f0-9]{1,4}(?>:[a-f0-9]{1,4}){0,4})?' .
                                    '::(?>(?:[a-f0-9]{1,4}(?>:[a-f0-9]{1,4}){0,4}):)?))?(?>25[0-5]|2[0-4][0-9]|1[0-9]{2}' .
                                    '|[1-9]?[0-9])(?>\.(?>25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}))\])$/isD',
                                    $data[$input]
                                );
                                break;
                            case 'html5':
                                /**
                                 * This is the pattern used in the HTML5 spec for validation of 'email' type form input elements.
                                 * @link http://www.whatwg.org/specs/web-apps/current-work/#e-mail-state-(type=email)
                                 */
                                $valid = (boolean)preg_match(
                                    '/^[a-zA-Z0-9.!#$%&\'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}' .
                                    '[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/sD',
                                    $data[$input]
                                );
                                break;
                            case 'noregex':
                                //No PCRE! Do something _very_ approximate!
                                //Check the address is 3 chars or longer and contains an @ that's not the first or last char
                                $valid = (strlen($data[$input]) >= 3
                                    and strpos($data[$input], '@') >= 1
                                    and strpos($data[$input], '@') != strlen($data[$input]) - 1);
                                break;
                            case 'php':
                                $valid = (boolean)filter_var($data[$input], FILTER_VALIDATE_EMAIL);
                                break;
                        }
                        if(!$valid){
                            self::$errors[] = ["data[{$input}]" => self::$messages['email']];
                        }
                    break;
            }
        }
    }

    /**
     * @param $rule
     * @param $message
     */
    public static function setMessages($rule, $message)
    {
        self::$messages[$rule] = $message;
    }
}