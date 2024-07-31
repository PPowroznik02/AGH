<div>
    <?php if (isset($authUser) and $authUser != null) { ?>
    <h1> Welcome to page with secure information </h1>
    <?php } else { ?>
    <h1> First you must log in </h1>
    <?php } ?>
</div>

