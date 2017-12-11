<?php

namespace helpers;

class Captcha
{
    private $key            = '';
    private $width          = 100;				//Ширина изображения
    private $height         = 60;				//Высота изображения
    private $font_size      = 16;   			//Размер шрифта
    private $let_amount     = 4;			//Количество символов, которые нужно набрать
    private $fon_let_amount = 30;		//Количество символов на фоне
    private $font           = "";	//Путь к шрифту
    private $letters        = [];
    private $colors         = [90,110,130,150,170,190,210];
    private $bg_color       = [255,255,255];

    public function __construct($key = 'secpic', $config = [])
    {
        $this->key = $key;

        $this->letters = range('a','z');
        $this->font    =  DOCROOT . "/themes/backend/assets/fonts/RobotoBold.ttf";

        foreach ($config as $k=>$v) {
            $this->{$k} = $v;
        }
    }

    public function make()
    {
        $src = imagecreatetruecolor($this->width, $this->height);

        $bg = imagecolorallocate($src,$this->bg_color[0],$this->bg_color[1],$this->bg_color[2]);
        imagefill($src,0,0,$bg);

        $letters = $this->letters;

        for($i=0;$i < $this->fon_let_amount;$i++)
        {
            $color = imagecolorallocatealpha($src,rand(0,255),rand(0,255),rand(0,255),100);
            $letter = $letters[rand(0,sizeof($letters)-1)];
            $size = rand($this->font_size-2,$this->font_size+2);
            imagettftext($src,$size,rand(0,45),
                rand($this->width*0.1,$this->width-$this->width*0.1),
                rand($this->height*0.2,$this->height),$color,$this->font,$letter);
        }

        $code = []; $colors = $this->colors;

        for($i=0;$i < $this->let_amount;$i++)
        {
            $color = imagecolorallocatealpha($src,$colors[rand(0,sizeof($colors)-1)],
                $colors[rand(0,sizeof($colors)-1)],
                $colors[rand(0,sizeof($colors)-1)],rand(20,40));
            $letter = $letters[rand(0,sizeof($letters)-1)];
            $size = rand($this->font_size*2-2,$this->font_size*2+2);
            $x = ($i+1)*$this->font_size + rand(1,5);
            $y = (($this->height*2)/3) + rand(0,5);
            $code[] = $letter;
            imagettftext($src,$size,rand(0,15),$x,$y,$color,$this->font,$letter);
        }

        $code = implode("", $code);

        \system\core\Session::set($this->key, $code);

        header ("Content-type: image/gif");
        imagegif($src);die;
    }

    public function check()
    {
        $key = isset($_POST[$this->key]) ? $_POST[$this->key] : null;
        return \system\core\Session::get($this->key) == $key;
    }

    public function key()
    {
        return $this->key;
    }
}