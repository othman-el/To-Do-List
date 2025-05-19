<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}
require 'includes/db.php';


$user_id = $_SESSION['user_id'];
$user_stmt = $pdo->prepare("SELECT fname, lname FROM users WHERE id = ?");
$user_stmt->execute([$user_id]);
$user = $user_stmt->fetch(PDO::FETCH_ASSOC);
$fname = $user['fname'];
$lname = $user['lname'];


$stmt = $pdo->prepare("SELECT * FROM goals WHERE user_id = ?");
$stmt->execute([$user_id]);
$goals = $stmt->fetchAll(PDO::FETCH_ASSOC);

$total_goals = count($goals);
$completed_goals = count(array_filter($goals, fn($g) => $g['completed']));
$completion_rate = $total_goals > 0 ? round(($completed_goals / $total_goals) * 100) : 0;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <h2>Weekly Stats</h2>
        <p><strong>Total Goals:</strong> <?= $total_goals ?></p>
        <p><strong>Completed:</strong> <?= $completed_goals ?></p>
        <p><strong>Remaining:</strong> <?= $total_goals - $completed_goals ?></p>
        <div class="circular-progress">
            <svg viewBox="0 0 36 36">
                <path class="bg" d="M18 2.0845
                  a 15.9155 15.9155 0 0 1 0 31.831
                  a 15.9155 15.9155 0 0 1 0 -31.831"/>
                <path class="progress"
                  stroke-dasharray="<?= $completion_rate ?>, 100"
                  d="M18 2.0845
                    a 15.9155 15.9155 0 0 1 0 31.831
                    a 15.9155 15.9155 0 0 1 0 -31.831"/>
                <text x="18" y="20.35" class="percentage"><?= $completion_rate ?>%</text>
            </svg>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
        <h1>Welcome, <?= htmlspecialchars($fname) . ' ' . htmlspecialchars($lname) ?>✅</h1>
        <h1>My Weekly Goals</h1>
         <a href="logout.php" class="btn">Logout</a><br>
        <div class="goals-header">
            <a href="add_goal.php" class="btn">+ New Goal</a>
        </div>
        <table class="goals-table">
            <thead>
                <tr>
                    <th>GOAL</th>
                    <th>STATUS</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($goals as $goal): ?>
                <tr>
                    <td><?= htmlspecialchars($goal['title']) ?></td>
                    <td>
                        <div class="progress-bar">
                            <div class="<?= $goal['completed'] ? 'bar green' : 'bar red' ?>"
                                 style="width: <?= $goal['completed'] ? '100%' : '0%' ?>;">
                                <?= $goal['completed'] ? 'Completed' : 'PENDING' ?>
                            </div>
                        </div>
                    </td>
                    <td>
                        <?php if (!$goal['completed']): ?>
                        <a href="mark_done.php?id=<?= $goal['id'] ?>" class="btn btn-success" >Completed ✅ </a>
                        <a href="edit_goal.php?id=<?= $goal['id'] ?>" class="btn btn-warning" >Edit ✏️ </a>
                        <?php endif; ?>
                        <a href="delete_goal.php?id=<?= $goal['id'] ?>" class="btn btn-danger ">Delete ❌ </a>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
