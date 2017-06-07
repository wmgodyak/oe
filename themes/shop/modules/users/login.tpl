{extends 'layouts/pages/fw.tpl'}
{block name="container"}
   <div class="row">
       <div class="col-md-6 col-md-offset-3">
           <div class="block-form-login">
               <div class="block-form-registered">
                   <div class="block-title">
                       {t('users.login.form.title')}
                   </div>
                   <div class="block-content">
                       {t('users.login.form.description')}
                       <form method="post" action="login" id="usersLoginForm" data-href="{route('profile')}">
                           <div class="form-group">
                               <input type="text" required name="email" class="form-control" placeholder="{t('users.login.form.labels.email')}">
                           </div>
                           <div class="form-group">
                               <input type="password" required name="password" class="form-control" placeholder="{t('users.login.form.labels.password')}">
                           </div>
                           <div class="checkbox">
                               <label><input type="checkbox" name="remember" value="1"><span>{t('users.login.form.labels.remember')}</span></label>
                           </div>
                           <div class="checkbox">
                               <label><a href="{route('forgot-password')}">{t('users.login.links.fp')}</a></label>
                           </div>
                           <input type="hidden" name="token" value="{$token}">
                           <button type="submit" class="btn btn-inline">{t('users.login.form.labels.submit')}</button>
                       </form>
                   </div>
               </div>
           </div>
       </div>
   </div>
{/block}