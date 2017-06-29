<?php

namespace system\models;
use system\core\Template;

/**
 * Class Pagination
 *
 * Template example:
{if $pagination.pages|count}
    <div class="pagination">
        <ul>
            {if $pagination.prev !=''}
                <li><a href="{$pagination.prev}">&laquo;</a></li>
            {/if}
            {foreach $pagination.pages as $item}
                <li class="{$item.class}"><a class="pagination__link" {if $item.url}href="{$item.url}"{/if}>{$item.name}</a></li>
            {/foreach}
            {if $pagination.next != ''}
                <li><a href="{$pagination.next}">&raquo;</a></li>
            {/if}
        </ul>
    </div>
{/if}
 *
 * @package system\models
 */
class Pagination
{
    /**
     * total records
     * @var int
     */
    private $total = 0;
    /**
     * Items per page
     * @var int
     */
    private $ipp   = 5;

    /**
     * current page. ex: ?p=1
     * @var int
     */
    private $cur_p = 1;

    /**
     * GET parameter var name
     * @var string
     */
    private $p     = 'p';

    /**
     * @var array
     */
    private $pages = [];

    /**
     * next page url
     * @var null
     */
    private $next = null;

    /**
     * prev page url
     * @var null
     */
    private $prev = null;

    /**
     * Initialize pagination.
     * @param $total
     * @param $ipp
     * @param $url
     * @param array $qs
     * @return $this
     */
    public function init($total, $ipp, $url, array $qs = null)
    {
        $this->prev = null;
        $this->next = null;
        $this->pages = [];
        $this->cur_p = 1;

        $this->total = $total;
        $this->ipp   = $ipp;


        $this->cur_p = isset($_GET[$this->p]) ? (int)$_GET[$this->p] : 1;

        if (strpos($url, '?') === false) $url .= '?';
        
        $cts  = 2;
        $prev = $this->cur_p - 1;
        $next = $this->cur_p + 1;

        $last_page = ceil($this->total / $this->ipp);
        $lpm1 = $last_page - 1;
        $c = 1;

        if(isset($qs['p'])) unset($qs['p']);
//        if(isset($qs['ipp'])) unset($qs['ipp']);

        $qs = $qs ? '&'. http_build_query($qs) : null;

        /**
         * Calculate pages
         */

        if ($last_page > 1) {
            if ($this->cur_p > 1) {
                $_prev = $prev == 1 ? "" : "$this->p=$prev";
                $this->prev = $url . $_prev . $qs;
            }

            if ($last_page < 7 + ($cts * 2)) {
                for ($c = 1; $c <= $last_page; $c++) {
                    if ($c == $this->cur_p) {
                        $this->pages[] = ['url' =>  null, 'name' => $c, 'class' => 'active'];
                    } else {
                        $this->pages[] = ['url' =>  $url . "$this->p=$c" . $qs, 'name' => $c];
                    }
                }
            } elseif ($last_page > 5 + ($cts * 2)) {
                if ($this->cur_p < 1 + ($cts * 2)) {
                    for ($c = 1; $c < 4 + ($cts * 2); $c++) {
                        if ($c == $this->cur_p) {
                            $this->pages[] = ['url' =>  null, 'name' => $c, 'class' => 'active'];
                        } else {
                            $this->pages[] = ['url' =>  $url . "$this->p=$c" . $qs, 'name' => $c];
                        }
                    }
                    $this->pages[] = ['url' =>  null, 'name' => '...', 'class' => 'delimiter'];
                    $this->pages[] = ['url' =>  $url . "$this->p=$lpm1" . $qs, 'name' => $lpm1];
                    $this->pages[] = ['url' =>  $url . "$this->p=$last_page" . $qs, 'name' => $last_page];

                } elseif ($last_page - ($cts * 2) > $this->cur_p && $this->cur_p > ($cts * 2)) {
                    $this->pages[] = ['url' =>  $url  . $qs, 'name' => 1];
                    $this->pages[] = ['url' =>  $url . "$this->p=2" . $qs, 'name' => 2];
                    $this->pages[] = ['url' =>  null, 'name' => '...', 'class' => 'delimiter'];
                    for ($c = $this->cur_p - $cts; $c <= $this->cur_p + $cts; $c++) {
                        if ($c == $this->cur_p) {
                            $this->pages[] = ['url' =>  null, 'name' => $c, 'class' => 'active'];
                        } else {
                            $this->pages[] = ['url' =>  $url . "$this->p=$c" . $qs, 'name' => $c];
                        }
                    }
                    $this->pages[] = ['url' =>  null, 'name' => '..', 'class' => 'delimiter'];
                    $this->pages[] = ['url' =>  $url . "$this->p=$lpm1" . $qs, 'name' => $lpm1];
                    $this->pages[] = ['url' =>  $url . "$this->p=$last_page" . $qs, 'name' => $last_page];
                } else {
                    $this->pages[] = ['url' =>  $url  . $qs, 'name' => 1];
                    $this->pages[] = ['url' =>  $url . "$this->p=2" . $qs, 'name' => 2];
                    $this->pages[] = ['url' =>  null, 'name' => '..', 'class' => 'delimiter'];
                    for ($c = $last_page - (2 + ($cts * 2)); $c <= $last_page; $c++) {
                        if ($c == $this->cur_p) {
                            $this->pages[] = ['url' =>  null, 'name' => $c, 'class' => 'active'];
                        } else {
                            $this->pages[] = ['url' =>  $url . "$this->p=$c" . $qs, 'name' => $c];
                        }
                    }
                }
            }
            
            if ($this->cur_p < $c - 1) {
                $this->next = $url . "$this->p=$next" . $qs;
            }
        }

        return $this;
    }

    /**
     * Render template
     * @param string $tpl
     * @return string
     */
    public function display($tpl = 'chunks/pagination')
    {
        $template = Template::getInstance();

        $template->assign('pagination', ['pages' => $this->pages, 'prev' => $this->prev, 'next' => $this->next]);

        return $template->fetch($tpl);
    }

    /**
     * Return pages array
     * @return array
     */
    public function getPages()
    {
        return $this->pages;
    }

    /**
     * Generate start, num params
     * @return array
     */
    public function getLimit()
    {
        return [$this->getStart(), $this->ipp];
    }

    /**
     * Get start position for LIMIT on MySQL
     * @return int
     */
    public function getStart()
    {
        $start = $this->cur_p;
        $start --;

        if($start < 0) $start = 0;

        if($start > 0){
            $start = $start * $this->ipp;
        }

        return $start;
    }
}