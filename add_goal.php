<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}
require 'includes/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = trim($_POST['title']);
    if (!empty($title)) {
        $stmt = $pdo->prepare("INSERT INTO goals (user_id, title) VALUES (?, ?)");
        $stmt->execute([$_SESSION['user_id'], $title]);
        header('Location: dashboard.php');
        exit();
    } else {
        $error = "Please enter a goal title.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ADD GOAL</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="form-container">
    <h2>ADD A NEW GOAL</h2>
    <?php if (!empty($error)): ?>
        <p class="error"><?= $error ?></p>
    <?php endif; ?>
    <form method="POST">
        <label for="title">GOAL TITLE</label>
        <input type="text" name="title" id="title" required autofocus >
        <button type="submit" class="btn">ADD GOAL</button>
        <a href="dashboard.php" class="btn cancel">CANCEL</a>
    </form>
</div>
</body>
</html>
