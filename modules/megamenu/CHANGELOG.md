For example


2.0.7
=============
* GitHub requests:
    * [#2984](https://github.com/magento/magento2/issues/2984) -- Payment config settings not decrypted when used?

2.0.6
=============
* Functional fixes:
    * Fixed issue with Redis sessions.
    * Fixed issue with Varnish cache on GoDaddy.

* Security fixes:
    * This release contains several security fixes. We describe each issue in detail in the Magento Security Center (https://www.magento.com/security).

* Enhancements:
    * Management of file ownership and permissions have been made more flexible.
    * Support for using the Redis adapter to provide session storage.

2.0.5
=============
* Fixed bugs:
    * Fixed issue with HTML minification and comments
    * Fixed issue with cached CAPTCHA
    * Fixed issue with images not changing on swatches
    * Fixed issue with admin URL being indexed in search engines
    * Fixed issue with viewing products from shared wishlists
    * Fixed inconsistent data during installation
    * Fixed issue with saving custom customer attributes during checkout
    * Fixed issue with multiple newsletter subscriptions for same email
    * Fixed import issue for products with store code
* GitHub requests:
    * [#2795](https://github.com/magento/magento2/pull/2795) -- Fix Notice: Undefined property: Magento\Backend\Helper\Dashboard\Order::$_storeManager
    * [#2989](https://github.com/magento/magento2/issues/2989) -- Custom Options not working after editing product
* Various improvements:
    * Improved export performance
    * Fixed several performance issue with duplicated queries on category and CMS pages
