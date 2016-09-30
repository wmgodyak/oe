<?php
/**
 * OYiEngine 7
 * @author Volodymyr Hodiak mailto:support@otakoi.com
 * @copyright Copyright (c) 2015 Otakoyi.com
 * Date: 30.09.16 : 18:23
 */

namespace modules\newsletter\controllers\admin\newsletter\subscribers;

use modules\newsletter\models\admin\Subscribers;
use system\Engine;

defined("CPATH") or die();

class Import extends Engine
{
    private $dir = "tmp/newsletter/";
    private $subscribers;

    public function __construct()
    {
        parent::__construct();

        $this->subscribers = new Subscribers();
    }

    public function upload()
    {
        if($this->request->isPost() && !empty($_FILES['file']['tmp_name'])){

            $s = 0;  $m = null; $fname = null;

            if(!is_dir( DOCROOT . $this->dir)){
                mkdir(DOCROOT . $this->dir, 0777 , true);
            }

            $info = pathinfo($_FILES['file']['name']);
            if($info['extension'] != 'csv'){
                $m['file'] = "Wrong file extension. Only CSV. ";
            }

            if(empty($m)){
                $fname = 'import'. time() .'.csv';
                $uploadfile = $this->dir . $fname;
                $s = move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile);
            }



            $this->response->body(['s' => $s, 'f' => $fname, 'i' => $m])->asJSON();
        }
    }

    public function customize($file)
    {
        $s = 0;  $m = null;

        if( ! file_exists(DOCROOT . $this->dir . $file)){
            $m['file'] = "File not exists: {$this->dir}{$file}";
        }

        if(empty($m)){

            $allowed_cols  = [
                'email'    => 'email'
            ];

            $csv_cols = [];

            if ( ( $handle = fopen( DOCROOT . $this->dir . $file, "r" ) ) !== FALSE ) {

                while (($line = fgetcsv($handle)) !== FALSE) {
                    foreach ($line as $k=>$v) {
                        if(empty($v)) unset($line[$k]);
                    }
                    $csv_cols = $line;
                    $s = 1;
                    break;
                }
                fclose( $handle );
            }

            $this->template->assign('allowed_cols', $allowed_cols);
            $this->template->assign('csv_cols',     $csv_cols);
            $this->template->assign('file',     $file);

            $m = $this->template->fetch('modules/newsletter/subscribers/import/customize');
        }

        $this->response->body(['s' => $s, 'f' => $file, 'i' => $m])->asJSON();
    }

    public function process($id = null)
    {
        $s = 0; $m = null; $res = ['inserted' => 0, 'error' => null];

        $file     = $this->request->post('file');
        $csv_conf = $this->request->post('csv_conf');
        $meta     = $this->request->post('meta');

        if( ! file_exists(DOCROOT . $this->dir . $file)){
            $m['file'] = "File not exists";
        }

        if(empty($m)){
            if ( ( $handle = fopen( DOCROOT . $this->dir . $file, "r" ) ) !== FALSE ) {

                $i=0;
                while (($line = fgetcsv($handle)) !== FALSE) {

                    if($i == 0){
                        $i++;
                        continue;
                    }

                    $iv = []; $iv_meta = [];
                    foreach ($line as $k => $val) {

                        if(empty($csv_conf[$k])) continue;

                        if($csv_conf[$k] == 'meta' && empty($meta[$k])) continue;

                        if($csv_conf[$k] == 'meta'){
                            $iv_meta[$meta[$k]] = $val;
                            continue;
                        }

                        $iv[$csv_conf[$k]] = $val;
                    }

                    if(empty($iv)) continue;

                    if($this->subscribers->is($iv['email'])){
                        $res['error'][] = "User {$iv['email']} exists.";
                        continue;
                    }

                    $this->subscribers->beginTransaction();
                    $users_id = $this->subscribers->create($iv);

                    if($this->subscribers->hasError()){
                        $res['error'][] = $this->subscribers->getErrorMessage();
                        $this->subscribers->rollback();
                        continue;
                    }
                    if($users_id > 0){
                        if(!empty($iv_meta)){
                            foreach ($iv_meta as $meta_k => $meta_v) {
                                $this->subscribers->meta->create($users_id, $meta_k, $meta_v);
                            }
                        }
                        if($this->subscribers->hasError()){
                            $res['error'][] = $this->subscribers->getErrorMessage();
                            $this->subscribers->rollback();
                            continue;
                        }

                        $this->subscribers->commit();
                        $res['inserted'] ++;
                        $s=1;
                    }
                    $i++;
                }
                fclose( $handle );
            }
        }
        if(!empty($res['error'])) $res['error'] = implode('<br>', $res['error']);
        $this->response->body(['s' => $s, 'f' => $file, 'i' => $m, 'res' => $res])->asJSON();
    }

    public function index()
    {
        echo $this->template->fetch('modules/newsletter/subscribers/import/upload_form');
    }

    public function create()
    {
        // TODO: Implement create() method.
    }

    public function edit($id)
    {
        // TODO: Implement edit() method.
    }

    public function delete($id)
    {
        // TODO: Implement delete() method.
    }
}