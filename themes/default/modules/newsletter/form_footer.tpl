<div class="footer__heading">
    {$t.newsletter.block_title}
</div>

<div class="footer__subscription">
    <div class="text">
        {$t.newsletter.block_text}
    </div>
    <form action="route/newsletter/subscribe" method="post" class="newsletter-subscribe">
        <div class="input-row">
            <input type="email" placeholder="{$t.newsletter.label_email}" required name="data[email]">
        </div>
        <div class="btn-row">
            <button>{$t.newsletter.button}</button>
        </div>
        <input type="hidden" name="data[form]" value="footer">
    </form>
</div>