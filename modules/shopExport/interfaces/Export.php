<?php

namespace modules\shopExport\interfaces;

interface Export
{
    public function __construct($data, $settings);
    public function export();
}