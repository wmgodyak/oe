
<script>
    $(document).ready(function(){
        var  $tree = new engine.tree('themesTree');
        $tree.setUrl('./themes/tree/{$theme}').init();
    });
</script>