<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up() {
        Schema::create('commandes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('serveur_id')->constrained('users')->onDelete('cascade');
            $table->dateTime('date_commande')->default(now());
            $table->enum('statut', ['en préparation', 'prête'])->default('en préparation');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('commandes');
    }
};
