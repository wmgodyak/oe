{block name="footer"}
    <footer id="footer" class="footer color-bg">
        {block name="footer.inner"}{/block}
        <div class="copyright-bar">
            <div class="container">
                <div class="col-xs-12 col-sm-6 no-padding">
                    <div class="copyright">
                        Copyright © {date('Y')}
                        <a href="1">{$settings->get('company_name')}.</a>
                        - All rights Reserved
                    </div>
                </div>
            </div>
        </div>
    </footer>
{/block}