<?php

/**
 * HybridAuth
 * http://hybridauth.sourceforge.net | http://github.com/hybridauth/hybridauth
 * (c) 2009-2015, HybridAuth authors | http://hybridauth.sourceforge.net/licenses.html
 */
// ----------------------------------------------------------------------------------------
//	HybridAuth Config file: http://hybridauth.sourceforge.net/userguide/Configuration.html
// ----------------------------------------------------------------------------------------

return
		array(
			"base_url" => "http://e7.otakoyi.com.ua/vendor/hybridauth/",
			"providers" => array(
				"Facebook" => array(
					"enabled" => true,
					"keys" => array(
						"id" => "1763511677233254",
						"secret" => "73ecc87b997e88cf248d5ebb6d3adb60"
					),
					"trustForwarded" => false
				),
				"Vkontakte" => array ( // 'key' is your twitter application consumer key
					"enabled" => true,
					"keys" => array (
						"id" => "5629616",
						"secret" => "bQ05uA9EDUdmMdYRcqEu"
					)
				),
				"Google" => array ( // 'key' is your twitter application consumer key
					"enabled" => true,
					"keys" => array (
						"id" => "530082045902-1r7its3k9jp0ohhua99sh9hp58ut9g07.apps.googleusercontent.com",
						"secret" => "PkYojlfBcyOrKhb9MA_Y2FrV"
					)
				)
			),
			"debug_mode" => false,
			// Path to file writable by the web server. Required if 'debug_mode' is not false
			"debug_file" => "",
);
