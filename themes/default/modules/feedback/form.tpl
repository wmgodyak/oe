
<form id="feedback" method="post" class="form" action="route/feedback/process">
    <div class="form-group">
        <label for="fb_data_name">{$t.feedback.name}</label>
        <input id="fb_data_name" name="data[name]" required type="text">
    </div>
    <div class="form-group">
        <label for="fb_data_email">{$t.feedback.email}</label>
        <input id="fb_data_email" name="data[email]" required type="email">
    </div>
    <div class="form-group">
        <label for="fb_data_phone">{$t.feedback.phone}</label>
        <input id="fb_data_phone" name="data[phone]" >
    </div>
    <div class="form-group">
        <label for="fb_message">{$t.feedback.message}</label>
        <textarea name="data[message]" id="fb_data_message" cols="20" rows="5"></textarea>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <button type="submit" class="btn md red" >Надіслати</button>
</form>