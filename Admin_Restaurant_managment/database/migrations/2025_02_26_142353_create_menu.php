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
        Schema::create('menus', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->decimal('prix', 8, 2);
            $table->string('image')->nullable(); // Champ pour l'image
            $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('set null'); // Définition unique de user_id            $table->timestamps();
        });

        // Table pivot pour la relation many-to-many entre menus et catégories
        Schema::create('category_menu', function (Blueprint $table) {
            $table->id();
            $table->foreignId('menu_id')->constrained('menus')->onDelete('cascade');
            $table->foreignId('category_id')->constrained('categories')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('category_menu');
        Schema::dropIfExists('menus');
    }
};
