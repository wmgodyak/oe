<form role="form" id="feedback" action="ajax/feedback/send" method="post">
    <div class="response"></div>
    <div class="form-group">
        <label for="name">Your name</label>
        <input type="text" name="data[name]" class="form-control" id="data_name" required>
    </div>
    <div class="form-group">
        <label for="email">Email address</label>
        <input type="email" name="data[email]" class="form-control" id="data_email" required>
    </div>
    <div class="form-group">
        <label for="phone">Phone</label>
        <input type="text" name="data[phone]" class="form-control" id="data_phone" required>
    </div>
    <div class="form-group">
        <label for="message">Your message</label>
        <textarea name="data[message]" class="form-control" id="data_message" rows="6" required></textarea>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <div class="submit">
        <button type="submit" id="bSubmit" class="button button-small" data-loading-text="Sending..." data-complete-text="Send success!">Send</button>
    </div>
</form>