<?php

namespace modules\users\controllers\admin;

use modules\users\models\Users as U;
use system\Backend;

defined("CPATH") or die();

/**
 * Class Import
 * @package modules\users\controllers\admin
 */
class Import extends Backend
{
    private $dir = "tmp/users/";
    private $users;
    private $guest_group_id = 7;

    public function __construct()
    {
        parent::__construct();

        $this->users = new U();
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



            return ['s' => $s, 'f' => $fname, 'i' => $m];
        }
    }

    public function customize($file)
    {
        $s = 0;  $m = null;

        if( ! file_exists(DOCROOT . $this->dir . $file)){
            $m['file'] = "File not exists";
        }

        if(empty($m)){

            $allowed_cols  = [
                'group_id' => 'group_id',
                'name'     => 'name',
                'surname'  => 'surname',
                'phone'    => 'phone',
                'email'    => 'email',
                'created'  => 'created',
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

            $m = $this->template->fetch('modules/users/import/customize');
        }

        return ['s' => $s, 'f' => $file, 'i' => $m];
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

                    if($this->users->issetEmail($iv['email'])){
                        $res['error'][] = "User {$iv['email']} exists.";
                        continue;
                    }
/*
 * Wholesaler - ціна 1
Small Wholesaler - ціна 2
General - ціна 3
Retail - ціна 4
 */

                  switch($iv['group_id']){
                      case 'Wholesaler':
                          $iv['group_id'] = 5;
                          break;
                      case 'Small Wholesaler':
                          $iv['group_id'] = 6;
                          break;
                      case 'General':
                          $iv['group_id'] = 7;
                          break;
                      case 'Retail':
                          $iv['group_id'] = 8;
                          break;
                      default:
                          $iv['group_id'] = '';
                          break;
                  }

                    if(empty($iv['group_id'])){
                        $res['error'][] = "Empty group_id on {$iv['email']}. Assign to default group.";

                        $iv['group_id'] = $this->guest_group_id;
                    }

                    if(!isset($iv['surname']) && isset($iv['name']) && !empty($iv['name'])){
                        $a = explode(' ', $iv['name']);
                        if(isset($a[1])){
                            $iv['name'] = $a[0];
                            $iv['surname'] = $a[1];
                        }
                    }

                    $this->users->beginTransaction();
                    $users_id = $this->users->create($iv);

                    if($this->users->hasError()){
                        $res['error'][] = $this->users->getErrorMessage();
                        $this->users->rollback();
                        continue;
                    }
                    if($users_id > 0){
                        if(!empty($iv_meta)){
                            foreach ($iv_meta as $meta_k => $meta_v) {
                                $this->users->meta->create($users_id, $meta_k, $meta_v);
                            }
                        }
                        if($this->users->hasError()){
                            $res['error'][] = $this->users->getErrorMessage();
                            $this->users->rollback();
                            continue;
                        }

                        $this->users->commit();
                        $res['inserted'] ++;
                        $s=1;
                    }
                    $i++;
                }
                fclose( $handle );
            }
        }
        if(!empty($res['error'])) $res['error'] = implode('<br>', $res['error']);

        return ['s' => $s, 'f' => $file, 'i' => $m, 'res' => $res];
    }

    public function index()
    {
        echo $this->template->fetch('modules/users/import/upload_form');
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