<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules\Password;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $users = User::all();
            return response()->json($users);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }


    }

    /**
     * Store a newly created resource in storage.
     */
    public function login(Request $request)
    {
        try {
            $credentials = $request->validate([
                'email' => 'required|email',
                'password' => 'required|string|min:8',
            ],
            [
                'email.required' => 'Veuillez renseigner votre adresse email',
                'email.email' => 'Veuillez renseigner une adresse email valide',
                'password.required' => 'Veuillez renseigner votre mot de passe',
                'password.min' => 'Le mot de passe doit contenir au moins 8 caractères',
            ]
        );

            $user = User::where('email', $credentials['email'])->first();

            if (!$user || !Hash::check($credentials['password'], $user->password)) {
                return response()->json(['message' => 'Email ou mot de passe incorrect'], 401);
            }

            return response()->json([
                'message' => 'Connexion réussie',
                'user' => $user,
                'token' => $user->createToken('authToken')->plainTextToken
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }

    }

    /**
     * Display the specified resource.
     */
    public function register(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'nom' => 'required|string|max:255',
                'prenom' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users',
                'role' => 'required|in:serveur,cuisinier,admin',
                'username' => 'nullable|string|max:255|unique:users',
                'password' => ['required', Password::min(8)->letters()->numbers()],
            ],
            [
                'nom.required' => 'Veuillez renseigner votre nom',
                'nom.string' => 'Le nom doit être une chaîne de caractères',
                'nom.max' => 'Le nom ne doit pas dépasser 255 caractères',
                'prenom.required' => 'Veuillez renseigner votre prénom',
                'prenom.string' => 'Le prénom doit être une chaîne de caractères',
                'prenom.max' => 'Le prénom ne doit pas dépasser 255 caractères',
                'email.required' => 'Veuillez renseigner votre adresse email',
                'email.email' => 'Veuillez renseigner une adresse email valide',
                'email.max' => 'L\'adresse email ne doit pas dépasser 255 caractères',
                'email.unique' => 'Cette adresse email est déjà utilisée',
                'role.required' => 'Veuillez renseigner le rôle de l\'utilisateur',
                'role.in' => 'Le rôle doit être serveur, cuisinier ou admin',
                'username.max' => 'Le nom d\'utilisateur ne doit pas dépasser 255 caractères',
                'username.unique' => 'Ce nom d\'utilisateur est déjà utilisé',
                'password.required' => 'Veuillez renseigner votre mot de passe',
                'password.min' => 'Le mot de passe doit contenir au moins 8 caractères',
                'password.letters' => 'Le mot de passe doit contenir au moins une lettre',
                'password.numbers' => 'Le mot de passe doit contenir au moins un chiffre',

            ]
        );

            $user = User::create([
                'nom' => $validatedData['nom'],
                'prenom' => $validatedData['prenom'],
                'email' => $validatedData['email'],
                'role' => $validatedData['role'],
                'username' => $validatedData['username'] ?? null,
                'password' => Hash::make($validatedData['password']),
            ]);

            return response()->json([
                'message' => 'Utilisateur crée',
                'user' => $user,
                'token' => $user->createToken('authToken')->plainTextToken
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        try {
            // $user = Auth::user();
            $validatedData = $request->validate([
            'nom' => 'sometimes|string|max:255',
            'prenom' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $user->id,
            'username' => 'sometimes|string|max:255|unique:users,username,' . $user->id,
            'password' => 'sometimes|string|min:8|confirmed',
        ],[
            'email.unique' => 'Cette adresse email est déjà utilisée',
            'username.unique' => 'Ce nom d\'utilisateur est déjà utilisé',
            'password.min' => 'Le mot de passe doit contenir au moins 8 caractères',
            'password.confirmed' => 'Les mots de passe ne correspondent pas',
        ]
    );

        if (isset($validatedData['password'])) {
            $validatedData['password'] = Hash::make($validatedData['password']);
        }

        $user->update($validatedData);

        return response()->json([
            'message' => 'Profil mis à jour avec succès',
            'user' => $user
        ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Déconnexion
    public function logout(Request $request)
    {
        try {
            $request->user()->tokens()->delete();
            return response()->json([
                'message' => 'Déconnexion réussie',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        try {
            // $user = Auth::user();
            $user->delete();
            return response()->json([
                'message' => 'Utilisateur supprimé avec succès',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
