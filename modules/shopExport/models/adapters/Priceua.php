<?php
namespace modules\shopExport\models\adapters;

use modules\shopExport\interfaces\Export;

class Priceua implements Export
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
<price date=\"{$date}\">
    <currency id=\"{$this->settings['currency']['code']}\" rate=\"{$this->settings['currency']['rate']}\"/>
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
//            $utm = "?utm_source=promua&utm_medium=cpc&utm_campaign={$item['utm_campaign']}&utm_content={$item['utm_content']}&utm_term={$item['utm_term']}";
//            $utm = str_replace($this->search, $this->replace, $utm);
            $product['name'] = str_replace($this->search, $this->replace, $product['name']);
            $product['description'] = str_replace($this->search, $this->replace, $product['description']);
            echo <<<ITEM
        <item id="{$product['id']}" available="{$av}">
            <name>{$product['name']}</name>
            <categoryId>{$product['categories_id']}</categoryId>
            <price>{$product['price']}</price>
            <url>{$appurl}{$product['url']}</url>
            <image>{$appurl}{$product['image']}</image>
            <description>{$product['description']}</description>
        </item>

ITEM;
        }
        echo "</items>";
        echo "
</price>";

        header("Content-type: application/xml; charset=utf-8");
        header("Content-Disposition: inline; filename=export".date("YmdHis").".xml; charset=utf-8");
        ob_end_flush(); die;
    }
}