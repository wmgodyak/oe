<pre>
<?php

function d($v)
{
    print_r($v);
}

 $a = [
   169 => [170, 171, 172],
   163 => [198, 167],
   162 => [164, 165, 166]
 ];
/*
 * 170 198 164
 * 170 198 165
 * 170 198 166
 * 170 167 164
 * 170 167 165
 * 170 167 166
 * 171 198 164
 * 171 198 165
 * 171 198 166
 * 171 167 164
 * 171 167 165
 * 171 167 166
 * 172 198 164
 * 172 198 165
 * 172 198 166
 * 172 167 164
 * 172 167 165
 * 172 167 166
*/
$res = [];
function variants(&$res, $a, $m = null, $e = null) {
//    global $result;

    if (!$e) {
        $e = 1;
        foreach ($a as $k => $v) {
            $e *= count($v);
        }
    }

    $e--;
    if ($e < 0) return;

    if (!$m) {
        foreach ($a as $k => $v) {
            $m[$k] = 0;
        }
    }
    $r = array();
    foreach ($a as $k => $v) {
        $r[$k] = $v[$m[$k]];
    }
    $res[] = $r;
    $s = false;
    foreach (array_reverse($m, true) as $k => $v) {
        if (($v < (count($a[$k]) - 1)) && $s == false) {
            $m[$k]++;
            $s = true;
        } else {
            if ($s == false) {
                $m[$k] = 0;
            }
        }
    }
    if ($s) variants($res, $a, $m, $e);
}
variants($res, $a);
d($res);
die();

die;


function getOneValue($a, $_k = 0)
{
    $res = [];
    foreach ($a as $features_id => $item) {
        foreach ($item as $k => $v) {
            if($k == $_k){
                $res[] = $v;
            }
        }
    }

    return $res;
}
$t = count($a);
d($a);    // echo '--------------------------------<br>';
/*
    1. вирізати перший елемент масиву
    2. генеруємо варіанти
*/

    function v($a, $v)
    {
        $variant = [$v];
        foreach ($a as $fid=> $values) {
            foreach ($values as $k=>$value) {
                if($value == $v){
                    continue;
                }
            }
        }
    }

    $f = []; $variants = [];

    $i=0; $c = count($a);

    foreach ($a as $fid=> $values) {
        foreach ($values as $k=>$value) {
            echo $value, '<br>';
            v($a, $value);
        }
        echo '<br>';
    }




















//    $f = array_shift($a);

//    d($f); //d($a);


//    foreach ($f as $k=>$v) {

//        $variant = array_merge($variant, getValues($a, $k));
//
//        $variants[] = $variant;

//        $i=0;
//        while($i < 10){
//            $variant = [$v];
//            $r = getOneValue($a, $i);
//
//            if(!empty($r)){
//                $variant = array_merge($variant, $r);
//                if($t == count($variant))
//                    $variants[] = $variant;
//            }
//
//            $i++;
//        }
//    }

//    echo 'RES: ---------------------------------<br>';
//    d($variants);