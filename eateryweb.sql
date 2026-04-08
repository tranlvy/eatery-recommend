-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th4 08, 2026 lúc 07:32 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `eateryweb`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dish`
--

CREATE TABLE `dish` (
  `ID` int(11) NOT NULL,
  `NameDish` text NOT NULL,
  `Price` double NOT NULL,
  `EateryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dish`
--

INSERT INTO `dish` (`ID`, `NameDish`, `Price`, `EateryID`) VALUES
(1, 'Trà sữa trân châu', 25000, 1),
(2, 'Bánh tráng trộn', 20000, 1),
(3, 'Xoài lắc', 15000, 1),
(4, 'Cafe sữa đá', 40000, 2),
(5, 'Latte', 55000, 2),
(6, 'Bánh tiramisu', 60000, 2),
(7, 'Lẩu bò', 250000, 3),
(8, 'Ba chỉ nướng', 180000, 3),
(9, 'Hải sản nướng', 300000, 3),
(10, 'Tôm hùm nướng', 500000, 4),
(11, 'Cua rang me', 350000, 4),
(12, 'Ốc hương hấp', 300000, 4),
(13, 'Trà sữa matcha', 30000, 5),
(14, 'Trà đào cam sả', 35000, 5),
(15, 'Bánh flan', 20000, 5),
(16, 'Cơm gà xối mỡ', 45000, 6),
(17, 'Cơm sườn nướng', 50000, 6),
(18, 'Canh chua cá', 60000, 6),
(19, 'Cơm chay thập cẩm', 50000, 7),
(20, 'Bún chay', 45000, 7),
(21, 'Gỏi cuốn chay', 40000, 7),
(22, 'Buffet nướng', 299000, 8),
(23, 'Buffet lẩu', 259000, 8),
(24, 'Combo hải sản', 350000, 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `eatery`
--

CREATE TABLE `eatery` (
  `ID` int(11) NOT NULL,
  `NamePage` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `TypeOfPage` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ContactInfor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `TypeOfDishes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Services` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `eatery`
--

INSERT INTO `eatery` (`ID`, `NamePage`, `Address`, `TypeOfPage`, `ContactInfor`, `Description`, `TypeOfDishes`, `Services`) VALUES
(1, 'Quán Ăn Vặt Cô Ba', '12 Trần Phú, Đà Nẵng', 'ăn vặt,trà sữa', '0901234567', 'Quán ăn vặt giá rẻ, đông sinh viên, không gian vui vẻ', 'ăn vặt,trà sữa', 'wifi,takeaway'),
(2, 'Cafe Chill House', '45 Nguyễn Văn Linh, Đà Nẵng', 'cafe,trà sữa', '0912345678', 'Không gian yên tĩnh, decor đẹp, thích hợp học bài và sống ảo', 'cafe,bánh ngọt,trà sữa', 'wifi,máy lạnh'),
(3, 'Lẩu Nướng 99', '78 Lê Duẩn, Đà Nẵng', 'lẩu nướng,quán nhậu', '0923456789', 'Quán lẩu nướng đông vui, phù hợp đi nhóm bạn', 'lẩu nướng,hải sản,đồ nướng', 'bãi xe,máy lạnh'),
(4, 'Nhà Hàng Biển Xanh', '101 Võ Nguyên Giáp, Đà Nẵng', 'hải sản,nhà hàng', '0934567890', 'Nhà hàng view biển, sang trọng, hải sản tươi sống', 'hải sản', 'bãi xe,máy lạnh'),
(5, 'Trà Sữa Teen', '23 Hoàng Diệu, Đà Nẵng', 'trà sữa,ăn vặt', '0945678901', 'Không gian trẻ trung, giá rẻ, đông vui', 'trà sữa,ăn vặt', 'wifi'),
(6, 'Cơm Văn Phòng 24h', '56 Điện Biên Phủ, Đà Nẵng', 'cơm văn phòng', '0956789012', 'Phục vụ nhanh, phù hợp dân văn phòng, yên tĩnh', 'cơm văn phòng', 'máy lạnh,takeaway'),
(7, 'Quán Chay An Nhiên', '89 Nguyễn Tri Phương, Đà Nẵng', 'ăn chay,healthy', '0967890123', 'Không gian thanh tịnh, món ăn healthy', 'ăn chay,healthy', 'wifi,yên tĩnh'),
(8, 'Buffet BBQ King', '150 Hàm Nghi, Đà Nẵng', 'buffet,lẩu nướng', '0978901234', 'Buffet cao cấp, không gian sang trọng, nhiều món', 'buffet,lẩu nướng', 'bãi xe,máy lạnh');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `userrestaurantaction`
--

CREATE TABLE `userrestaurantaction` (
  `Id` int(11) NOT NULL,
  `IdUser` int(11) NOT NULL CHECK (`IdUser` >= 1),
  `IdPage` int(11) NOT NULL,
  `Starate` int(11) DEFAULT NULL CHECK (`Starate` between 1 and 5),
  `Like` tinyint(1) DEFAULT 0,
  `Collect` tinyint(1) DEFAULT 0,
  `Discuss` tinyint(1) DEFAULT 0,
  `CreatedAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `userrestaurantaction`
--

INSERT INTO `userrestaurantaction` (`Id`, `IdUser`, `IdPage`, `Starate`, `Like`, `Collect`, `Discuss`, `CreatedAt`) VALUES
(13, 1, 1, 5, 1, 1, 0, '2026-04-08 02:29:29'),
(14, 1, 2, 4, 1, 0, 1, '2026-04-08 02:29:29'),
(15, 1, 3, 3, 0, 1, 1, '2026-04-08 02:29:29'),
(16, 2, 1, 4, 1, 0, 0, '2026-04-08 02:29:29'),
(17, 2, 4, 5, 1, 1, 1, '2026-04-08 02:29:29'),
(18, 2, 5, 2, 0, 0, 1, '2026-04-08 02:29:29'),
(19, 3, 2, 5, 1, 1, 1, '2026-04-08 02:29:29'),
(20, 3, 3, 4, 0, 1, 0, '2026-04-08 02:29:29'),
(21, 3, 4, 3, 1, 0, 0, '2026-04-08 02:29:29'),
(22, 4, 1, 3, 0, 1, 1, '2026-04-08 02:29:29'),
(23, 4, 5, 5, 1, 1, 1, '2026-04-08 02:29:29'),
(24, 4, 3, 4, 1, 0, 1, '2026-04-08 02:29:29');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `AccName` text NOT NULL,
  `Email` text NOT NULL,
  `Interest` text NOT NULL,
  `gender` text NOT NULL,
  `Password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`ID`, `AccName`, `Email`, `Interest`, `gender`, `Password`) VALUES
(1, 'vyleee', 'vyleee@gmail.com', 'ăn vặt, trà sữa', 'Nam', '123456'),
(2, 'linh123', 'linh@gmail.com', 'đồ nướng, lẩu', 'Nữ', '123456'),
(3, 'huydev', 'huy@gmail.com', 'cơm văn phòng', 'Nam', '123456'),
(4, 'khangcute', 'khang@gmail.com', 'healthy, salad', 'Nữ', '123456');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_preferences`
--

CREATE TABLE `user_preferences` (
  `ID` int(11) NOT NULL,
  `User_Id` int(11) DEFAULT NULL,
  `FoodType` text DEFAULT NULL,
  `PriceRange` text DEFAULT NULL,
  `Distance` text DEFAULT NULL,
  `Ambience` text DEFAULT NULL,
  `Service` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_preferences`
--

INSERT INTO `user_preferences` (`ID`, `User_Id`, `FoodType`, `PriceRange`, `Distance`, `Ambience`, `Service`) VALUES
(1, 1, 'ăn vặt', 'rẻ', 'gần', 'đông vui', 'wifi'),
(2, 2, 'cafe', 'trung bình', 'gần', 'chill', 'máy lạnh'),
(3, 3, 'lẩu nướng', 'cao', 'xa', 'đông vui', 'bãi xe'),
(4, 4, 'ăn vặt', 'rẻ', 'gần', 'yên tĩnh', 'takeaway'),
(5, 5, 'cafe', 'trung bình', 'gần', 'sống ảo', 'wifi'),
(6, 6, 'buffet', 'cao', 'xa', 'sang trọng', 'máy lạnh'),
(7, 7, 'trà sữa', 'rẻ', 'gần', 'đông vui', 'wifi'),
(8, 8, 'cơm văn phòng', 'trung bình', 'gần', 'yên tĩnh', 'máy lạnh'),
(9, 9, 'ăn chay', 'trung bình', 'xa', 'yên tĩnh', 'wifi'),
(10, 10, 'hải sản', 'cao', 'xa', 'đông vui', 'bãi xe');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `dish`
--
ALTER TABLE `dish`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_dish_eatery` (`EateryID`);

--
-- Chỉ mục cho bảng `eatery`
--
ALTER TABLE `eatery`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `userrestaurantaction`
--
ALTER TABLE `userrestaurantaction`
  ADD PRIMARY KEY (`Id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Chỉ mục cho bảng `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `dish`
--
ALTER TABLE `dish`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `eatery`
--
ALTER TABLE `eatery`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `userrestaurantaction`
--
ALTER TABLE `userrestaurantaction`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
