<?php

/**
 * @author Volodymyr Hodiak
 * @company otakoyi.com
 * Date: 24.11.15
 * Time: 18:01
 * Description:
 * Призначений для генерації рандомних метатегів для посилання
 * Формат файлу з метаданими .csv
 * Приклад даних в файлі
    url,name,title
    http://otakoyi.com/uk/rozrobka-saytiv,Розробка сайтів,Розробка сайтів Львів
    http://otakoyi.com/uk/rozrobka-saytiv,Розробка сайтів 1,Розробка сайтів Львів
    http://otakoyi.com/uk/rozrobka-saytiv,Розробка сайтів 2,Розробка сайтів Львів
 *  Delimiter можна поміняти в конфігу
 * Буде створено файл кешу .cache, де будуть фіксуватись метатеги відносно $_SERVER['QUERY_STRING']
 *
 * Використання
 *  підключаю клас
    include_once "SeoLink.php";

    // отримаю масив метаданих для даної сторінки
    $meta = SeoLink::getMeta('http://otakoyi.com/uk/rozrobka-saytiv');
    вигляд масиву:
    Array
    (
       [name] => Розробка сайтів
       [title] => Розробка сайтів Львів
       [url] => http://otakoyi.com/uk/rozrobka-saytiv
    )

   // формую своє посилання
    echo "<a href='$meta['url']' title='$meta['title']'>{$meta['name']}</a>";

    // виводжу на екран посилання по шаблону для сторінки
    echo SeoLink::displayLink('http://otakoyi.com/uk/rozrobka-saytiv');

    // шаблон можна поміняти
    echo SeoLink::displayLink('http://otakoyi.com/uk/rozrobka-saytiv', "<a href='{url}' class='copy' title='{title}'>{name}</a>");
 */
class SeoLink
{
    /**
     * назва файлу з даними
     * @var string
     */
    private static $filename = 'links.csv';
    /**
     * розділюач
     * @var string
     */
    private static $delimiter = ',';
    /**
     * шаблон посилання по замовчуванню
     * @var string
     */
    private static $tpl = "<a href='{url}' title='{title}'>{name}</a>";
    /**
     * кеш даних
     * @var array
     */
    private static $data = array();
    /**
     * розширення файлу кешу
     * @var string
     */
    private static $cache_ext = '.cache';
    /**
     * дані файлу кешу
     * @var array
     */
    private static $cache = array();

    /**
     * Повертає метатеги для посилання
     * @param $url string посилання на сторінку
     * @param null $filename назва файлу з базою метаданих
     * @return array
     * @throws Exception
     */
    public static function getMeta($url, $filename = null)
    {
        $qs = md5($_SERVER['REQUEST_URI'] .'x' .$_SERVER['QUERY_STRING']);

        if( $filename ){ self::$filename = $filename; }

        // зчитуєм дані з файлу
        self::getData();

        // вибираю одну
        if(!isset(self::$data[$url])) throw new Exception("Для посилання {$url} відсутні метадані");

        // зчитую кеш
        self::readCache();

        $i = rand(0, count(self::$data[$url]) -1);

        if(isset(self::$cache[$qs])) {
            $meta = self::$data[$url][self::$cache[$qs]];
        } else {
//            if(!isset(self::$cache[$qs])) self::$cache[$qs] = null;
            self::$cache[$qs] = $i;
            $meta = self::$data[$url][$i];
        }

        // оновлюю кеш
        self::saveCache();

        // дописую урл
        $meta['url'] = $url;

        return $meta;
    }

    /**
     * генерує html посилання
     * @param $url
     * @param null $tpl
     * @param null $filename
     * @return mixed
     * @throws Exception
     */
    public static function displayLink($url, $tpl = null, $filename = null)
    {
        if( $tpl ) { self::$tpl = $tpl; }

        // отримую мета дані
        $meta = self::getMeta($url, $filename);

        // рендерю посилання
        return str_replace
        (
            array('{url}', '{name}', '{title}'),
            array($meta['url'], $meta['name'], $meta['title']),
            self::$tpl
        );
    }

    /**
     * зчитує дані з файлу в кеш
     */
    private static function getData()
    {
        if (($handle = fopen(self::$filename, "r")) !== FALSE) {
            while (($data = fgetcsv($handle, 1000, self::$delimiter)) !== FALSE) {
                self::$data[$data[0]][] = array(
                    'name'  => $data[1],
                    'title' => $data[2]
                );
            }
            fclose($handle);
        }
    }

    /**
     * зчитує файл кешу
     */
    private static function readCache()
    {
        if( !file_exists(self::$filename . self::$cache_ext)) return;

        $c = file_get_contents(self::$filename . self::$cache_ext);
        if(!empty($c)){
            self::$cache = unserialize($c);
        }
    }

    /**
     * записує в кеш
     */
    private static function saveCache()
    {
        file_put_contents(self::$filename . self::$cache_ext, serialize( self::$cache ));
    }
}