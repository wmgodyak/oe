<?php
namespace modules\shopExport\models\adapters;

use modules\shopExport\interfaces\Export;

/**
 * Class Nadavi
 * @package modules\shopExport\models\adapters
 */
class Nadavi implements Export
{
    private $data;
    private $settings;

    private $search = array('<', '>', '&', "'", '"');
    private $replace = array('&lt;', '&gt;', '&amp;', '&apos;', '&quot;');

    public function __construct($data, $settings)
    {
        $this->data     = $data;
        $this->settings = $settings;
    }

    public function export()
    {
        $appurl = APPURL;
        $date = date("Y-m-d H:i");
        ob_start();
        echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<yml_catalog date=\"{$date}\">
    <shop>
        <name>{$this->settings['company']}</name>
        <url>{$appurl}</url>
        <currencies>
            <currency id=\"{$this->settings['currency']['code']}\" rate=\"{$this->settings['currency']['rate']}\"/>
        </currencies>
        <catalog>
            <category id=\"1\">Каталог</category>
        ";
        foreach ($this->data['categories'] as $category) {
            $category['parent_id'] = $category['parent_id'] == 0 ? 1 : $category['parent_id'];
            echo "<category id=\"{$category['id']}\" parentID=\"{$category['parent_id']}\">{$category['name']}</category>\r\n";
        }
        echo "</catalog>";
        echo "<items>";
        foreach ($this->data['products'] as $product) {
            $av = $product['in_stock'] == 1 ? 'true' : 'false';
            echo <<<ITEM
            <item id="{$product['id']}" available="{$av}">
                <name>{$product['name']}</name>
                <categoryId>{$product['categories_id']}</categoryId>
                <price>{$product['price']}</price>
                <currencyId>{$product['currency_code']}</currencyId>
                <url>{$appurl}{$product['url']}</url>
                <picture>{$appurl}{$product['image']}</picture>
                <description>{$product['description']}</description>
            </item>
ITEM;
        }
        echo "</items>";
        echo "
    </shop>
</yml_catalog>";

        header("Content-type: application/xml; charset=utf-8");
        header("Content-Disposition: inline; filename=export".date("YmdHis").".xml; charset=utf-8");
        ob_end_flush(); die;
    }
}