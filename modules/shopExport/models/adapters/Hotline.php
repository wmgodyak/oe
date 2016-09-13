<?php
namespace modules\shopExport\models\adapters;

use modules\shopExport\interfaces\Export;

/**
 * Class Hotline
 * @package modules\shopExport\models\adapters
 */
class Hotline implements Export
{
    private $data;
    private $settings;

    public function __construct($data, $settings)
    {
        $this->data     = $data;
        $this->settings = $settings;
    }

    public function export()
    {
        $date = date("Y-m-d H:i");
        ob_start();
        echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<price>
    <date>{$date}</date>
    <firmName>{$this->settings['company']}</firmName>
    <categories>
        <category>
            <id>1</id>
            <name>Каталог</name>
        </category>";
        foreach ($this->data['categories'] as $category) {
            $category['parent_id'] = $category['parent_id'] == 0 ? 1 : $category['parent_id'];
            echo "
        <category>
            <id>{$category['id']}</id>
            <parentId>{$category['parent_id']}</parentId>
            <name>{$category['name']}</name>
        </category>";
        }
echo "</categories>";
        $appurl = APPURL;
        foreach ($this->data['products'] as $product) {
            echo <<<ITEM
        <item>
            <id>{$product['id']}</id>
            <categoryId>{$product['categories_id']}</categoryId>
            <name>{$product['name']}</name>
            <description>{$product['description']}</description>
            <url>{$appurl}{$product['url']}</url>
            <image>{$appurl}{$product['image']}</image>
            <priceR{$product['currency_code']}>{$product['price']}</priceR{$product['currency_code']}>
        </item>
ITEM;
        }
echo "</price>";

        header("Content-type: application/xml; charset=utf-8");
        header("Content-Disposition: inline; filename=export".date("YmdHis").".xml; charset=utf-8");
        ob_end_flush(); die;
    }
}