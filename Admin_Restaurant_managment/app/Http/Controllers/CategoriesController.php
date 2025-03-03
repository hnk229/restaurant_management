<?php

namespace App\Http\Controllers;

use App\Models\Categories;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class CategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        $categories = Categories::all();
        return response()->json($categories);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'name' => 'required|string|max:255|unique:categories,name',
                    'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                ],
                [
                    'name.required' => 'Le nom de la catégorie est obligatoire.',
                    'name.unique' => 'Ce nom de catégorie existe déjà.',
                    'image.image' => 'Le fichier doit être une image.',
                    'image.mimes' => 'Le fichier doit être de type : jpeg, png, jpg, ou gif.',
                    'image.max' => 'Le fichier ne doit pas dépasser 2 Mo.',
                ]
            );

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            $imagePath = null;
            if ($request->hasFile('image')) {
                $fileName = time() . '_' . uniqid() . '.' . $request->file('image')->getClientOriginalExtension();
                $imagePath = $request->file('image')->storeAs('categories', $fileName, 'public');
            }

            $categorie = Categories::create([
                'name' => $request->name,
                'image' => $imagePath ? asset('storage/' . $imagePath) : null,
            ]);

            return response()->json($categorie, 201);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    /**
     * Afficher une catégorie spécifique.
     */
    public function show($id)
    {
        $categorie = Categories::find($id);
        if (!$categorie) {
            return response()->json(['message' => 'Catégorie non trouvée'], 404);
        }

        return response()->json($categorie);
    }

    /**
     * Mettre à jour une catégorie.
     */
    public function update(Request $request, Categories $category)
    {
        try {
            // logger('Requête reçue :', $request->all()); // Utilisez logger() pour afficher les logs dans le terminal
            // var_dump($request);
            // dd($request->all());
            $validator = Validator::make(
                $request->all(),
                [
                    'name' => 'required|string|max:255|unique:categories,name,' . $category->id,
                    'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                ],
                [
                    'name.required' => 'Le nom de la catégorie est obligatoire.',
                    'name.unique' => 'Ce nom de catégorie existe déjà.',
                    'image.image' => 'Le fichier doit être une image.',
                    'image.mimes' => 'Le fichier doit être de type : jpeg, png, jpg, ou gif.',
                    'image.max' => 'Le fichier ne doit pas dépasser 2 Mo.',
                ]
            );

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            if ($request->has('name')) {
                $category->name = $request->name;
            }
            // Enregistre la nouvelle image si elle existe
            if ($request->hasFile('image')) {
                // Supprime l'ancienne image si elle existe
                if ($category->image) {
                    $oldImagePath = $category->image ? str_replace('/storage/', '', parse_url($category->image, PHP_URL_PATH)) : null;
                    Storage::disk('public')->delete($oldImagePath);
                }
                // Enregistre la nouvelle image
                $fileName = time() . '_' . uniqid() . '.' . $request->file('image')->getClientOriginalExtension();
                $imagePath = $request->file('image')->storeAs('categories', $fileName, 'public');
                $category->image = $imagePath ? asset('storage/' . $imagePath) : null;
            }

            $category->save();

            return response()->json($category);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    /**
     * Supprimer une catégorie.
     */
    public function destroy($id)
    {
        $categorie = Categories::find($id);
        if (!$categorie) {
            return response()->json(['message' => 'Catégorie non trouvée'], 404);
        }

        $categorie->delete();

        return response()->json(['message' => 'Catégorie supprimée avec succès']);
    }
}
