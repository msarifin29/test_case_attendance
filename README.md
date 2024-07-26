# attendance

Required Flutter 3.16 or higher

This App using supabase for backend

You can replace with your supabase by follwing this stepe :

1. Create New Account or Sign In https://supabase.com/
2. Create New Project
3. In your Dashboard click Database and Add New Table
4. Edit Name table to `location` to create new Table with name todos
5. Disable checkbox `Enable Row Level Security (RLS)`
6. Click Add Column , edit Name with `lat` to create new column with name title,
   select Type to float and set as `0.0`
7. Click Add Column , edit Name with `long` to create new column with name description,
   select Type to float and set as `0.0`
8. Save
9. Repeat 3 - 8 with name table `attendances` , column 1 name `radius` type `float` with default `0.0` and column 2 with name `status` type `varchar` with default empty string.

## Notes 
Replace `BASE_URL` and `API_KEY` with your supabase in Dashboard

### How to Run 

1. Create new file .env in the root project
2. Copy BASE_URL AND API_KEY in your `.env` file
```
BASE_URL=[your baseURL];
API_KEY=[your supabase keyt];
```
3. Update your pupspec.yaml file by following this code
```
assets:
    - .env
```
4. Run `flutter pub get`
