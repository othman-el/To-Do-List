<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

require 'includes/db.php';

$id = $_GET['id'] ?? null;

// Get the existing goal
$stmt = $pdo->prepare("SELECT * FROM goals WHERE id = ? AND user_id = ?");
$stmt->execute([$id, $_SESSION['user_id']]);
$goal = $stmt->fetch();

if (!$goal) {
    echo "Goal not found.";
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = trim($_POST['title']);
    if (!empty($title)) {
        $update = $pdo->prepare("UPDATE goals SET title = ? WHERE id = ? AND user_id = ?");
        $update->execute([$title, $id, $_SESSION['user_id']]);
        header("Location: dashboard.php");
        exit();
    } else {
        $error = "Goal title cannot be empty.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Goal</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="form-container">
    <h2>Edit Goal</h2>
    <?php if (!empty($error)): ?>
        <p class="error"><?= $error ?></p>
    <?php endif; ?>
    <form method="POST">
        <label for="title">Goal Title</label>
        <input type="text" name="title" id="title" value="<?= htmlspecialchars($goal['title']) ?>" required>
        <button type="submit" class="btn">Update</button>
        <a href="dashboard.php" class="btn cancel">Cancel</a>
    </form>
</div>
</body>
</html>
