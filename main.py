import sys
sys.stdout.reconfigure(encoding='utf-8')

import mysql.connector
import pandas as pd

# ====== PHÂN LOẠI GIÁ ======
def get_price_level(avg_price):
    if avg_price < 50000:
        return "rẻ"
    elif avg_price < 150000:
        return "trung bình"
    else:
        return "cao"

# ====== LẤY SỞ THÍCH ======
def get_user_preferences(conn, user_id):
    query = f"""
        SELECT * FROM user_preferences 
        WHERE User_Id = {user_id}
        ORDER BY ID DESC LIMIT 1
    """
    df = pd.read_sql(query, conn)
    return df.iloc[0] if not df.empty else None

# ====== LẤY QUÁN + GIÁ ======
def get_eatery_data(conn):
    query = """
        SELECT e.ID, e.NamePage, e.TypeOfPage, e.TypeOfDishes, 
               e.Description, e.Services,
               AVG(d.Price) as avg_price
        FROM eatery e
        JOIN dish d ON e.ID = d.EateryID
        GROUP BY e.ID
    """
    return pd.read_sql(query, conn)

# ====== LẤY MÓN ======
def get_dishes(conn):
    query = "SELECT * FROM dish"
    return pd.read_sql(query, conn)

# ====== TÍNH ĐIỂM ======
def calculate_score(pref, row):
    score = 0

    # FOOD TYPE
    restaurant_types = str(row["TypeOfPage"]).split(",")
    user_types = str(pref["FoodType"]).split(",")

    if any(t.strip() in restaurant_types for t in user_types):
        score += 2

    # PRICE
    price_level = get_price_level(row["avg_price"])
    if price_level == pref["PriceRange"]:
        score += 2

    # AMBIENCE
    if pref["Ambience"] in str(row["Description"]):
        score += 1

    # SERVICE
    if pref["Service"] in str(row["Services"]):
        score += 1

    return score

# ====== LẤY HÀNH VI NGƯỜI DÙNG ======
def get_user_actions(conn):
    query = "SELECT * FROM UserRestaurantAction"
    df = pd.read_sql(query, conn)
    # Tính điểm tương tác tổng hợp
    df['interaction_score'] = df['Like'].astype(int) + df['Collect'].astype(int) + df['Discuss'].astype(int)
    return df

# ====== RECOMMEND (chỉ thêm mật độ tương tác) ======
def recommend_restaurants(conn, user_id=1, top_n=5):

    pref = get_user_preferences(conn, user_id)
    if pref is None:
        print("❌ Không có sở thích!")
        return

    eatery_df = get_eatery_data(conn)
    dish_df = get_dishes(conn)
    actions_df = get_user_actions(conn)

    results = []

    for _, row in eatery_df.iterrows():
        score = calculate_score(pref, row)

        dishes = dish_df[dish_df["EateryID"] == row["ID"]]["NameDish"].tolist()
        top_dishes = ", ".join(dishes[:3])

        # Tính mật độ tương tác trung bình
        page_actions = actions_df[actions_df["IdPage"] == row["ID"]]
        if not page_actions.empty:
            interaction_density = page_actions['interaction_score'].mean()
        else:
            interaction_density = 0

        results.append({
            "Name": row["NamePage"],
            "Score": score,
            "Price": get_price_level(row["avg_price"]),
            "AvgPrice": int(row["avg_price"]),
            "TopDishes": top_dishes,
            "InteractionDensity": round(interaction_density,2)
        })

    result_df = pd.DataFrame(results)

    # ====== 1. BẢNG CHÍNH (TOP MATCH) ======
    top_match = result_df.sort_values(by="Score", ascending=False).copy()

    # ====== 2. GIÁ RẺ ======
    cheap_df = result_df[result_df["Price"] == "rẻ"] \
        .sort_values(by="Score", ascending=False).copy()

    # ====== 3. KHÁM PHÁ (score thấp hơn một chút) ======
    explore_df = result_df.sort_values(by="Score", ascending=True).tail(top_n).copy()

    # ====== HÀM THÊM STT ======
    def add_stt(df):
        df = df.reset_index(drop=True)
        df.index = df.index + 1
        df.insert(0, "STT", df.index)
        return df

    top_match = add_stt(top_match)
    cheap_df = add_stt(cheap_df)
    explore_df = add_stt(explore_df)

    # ====== OUTPUT ======
    print("\n🔥 ====== TOP PHÙ HỢP NHẤT ======\n")
    print(top_match.head(top_n).to_string(index=False))

    print("\n💸 ====== QUÁN GIÁ RẺ ======\n")
    print(cheap_df.head(top_n).to_string(index=False))

    print("\n🎯 ====== GỢI Ý KHÁM PHÁ ======\n")
    print(explore_df.to_string(index=False))

    return {
        "top_match": top_match.head(top_n),
        "cheap": cheap_df.head(top_n),
        "explore": explore_df
    }




# ====== MAIN ======
try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="eateryweb"
    )
    query = "SELECT * FROM users" 
    df = pd.read_sql(query, conn) 
    print(df.head())

    user_id = int(input("👉 Nhập user_id: "))
    recommend_restaurants(conn, user_id)

except Exception as e:
    print("Lỗi:", e)

finally:
    if 'conn' in locals() and conn.is_connected():
        conn.close()